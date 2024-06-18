# frozen_string_literal: true

class InventoryItemsController < ApplicationController
  before_action :authenticate_api_user!

  def index
    @items = current_business_unit.inventory_items
    render json: @items
  end

  def create
    @item = current_business_unit.inventory_items.new(item_params)
    if @item.save
      render json: @item, status: :created
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:inventory_item).permit(:name, :quantity, :price, :item_type, :inventory_category_id)
  end

  def current_business_unit
    @current_business_unit ||= current_api_user.business_units.find(params[:business_unit_id])
  end
end
