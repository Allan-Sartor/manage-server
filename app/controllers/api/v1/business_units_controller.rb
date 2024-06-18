# frozen_string_literal: true

module Api
  module V1
    class BusinessUnitsController < ApplicationController
      before_action :authenticate_api_user!

      def index
        @business_units = current_api_user.business_unit
        render json: @business_units
      end

      def show
        @business_unit = BusinessUnit.find(params[:id])
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
        @business_unit = BusinessUnit.find(params[:id])
        if @business_unit.update(business_unit_params)
          render json: @business_unit
        else
          render json: @business_unit.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @business_unit = BusinessUnit.find(params[:id])
        @business_unit.destroy
        head :no_content
      end

      private

      def business_unit_params
        params.require(:business_unit).permit(:name, :plan_id, :cnpj, :state_registration, :municipal_registration, :legal_name, :trade_name)
      end
    end
  end
end
