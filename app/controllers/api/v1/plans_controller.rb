# frozen_string_literal: true

module Api
  module V1
    class PlansController < ApplicationController
      before_action :authenticate_api_user!, except: [:index, :show]
      before_action :set_plan, only: [:update]
      def index
        @plans = Plan.all
        render json: @plans
      end

      def show
        @plan = Plan.find(params[:id])
        render json: @plan
      end

      def update
        if @plan.update(plan_params)
          render json: @plan
        else
          render json: @plan.errors, status: :unprocessable_entity
        end
      end

      private

      def plan_params
        params.require(:plan).permit(:price, :discount, :max_business_units, :name)
      end

      def set_plan
        @plan = Plan.find(params[:id])
      end
    end
  end
end
