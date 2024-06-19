# frozen_string_literal: true

module Api
  module V1
    class BusinessUnitsController < ApplicationController
      before_action :authenticate_api_user!
      before_action :set_business_unit, only: [:show, :update, :destroy]

      def index
        @business_units = current_api_user.business_units.all
        render json: @business_units
      end

      def show
        render json: @business_unit
      end

      def create
        unless current_api_user.can_create_business_unit?
          render json: { error: 'You have reached the maximum number of business units for your plan.' }, status: :forbidden
          return
        end

        @business_unit = current_api_user.business_units.new(business_unit_params)
        if @business_unit.save
          render json: @business_unit, status: :created
        else
          render json: @business_unit.errors, status: :unprocessable_entity
        end
      end

      def update
        if @business_unit.update(business_unit_params)
          render json: @business_unit
        else
          render json: @business_unit.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if current_api_user.business_units.count == 1
          render json: { error: 'Cannot delete the only business unit.' }, status: :forbidden
          return
        end

        if @business_unit.transactions.exists? || @business_unit.clients.exists?
          render json: { error: 'Cannot delete business unit with associated transactions or clients.' }, status: :forbidden
          return
        end

        @business_unit.destroy
        head :no_content
      end

      private

      def set_business_unit
        @business_unit = if current_api_user.business_units.count > 1
                           current_api_user.business_units.find(params[:id])
                         else
                           current_api_user.business_units.first
                         end
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Business unit not found' }, status: :not_found
      end

      def business_unit_params
        params.require(:business_unit).permit(:name, :plan_id, :cnpj, :state_registration, :municipal_registration, :legal_name, :trade_name)
      end
    end
  end
end
