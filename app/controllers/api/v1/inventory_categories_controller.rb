# frozen_string_literal: true

module Api
  module V1
    class InventoryCategoriesController < ApplicationController
      before_action :authenticate_api_user!

      def index
        @categories = current_business_unit.inventory_categories
        render json: @categories
      end

      def create
        @category = current_business_unit.inventory_categories.new(category_params)
        if @category.save
          render json: @category, status: :created
        else
          render json: @category.errors, status: :unprocessable_entity
        end
      end

      private

      def category_params
        params.require(:inventory_category).permit(:name)
      end

      def current_business_unit
        @current_business_unit ||= current_api_user.business_units.find(params[:business_unit_id])
      end
    end
  end
end
