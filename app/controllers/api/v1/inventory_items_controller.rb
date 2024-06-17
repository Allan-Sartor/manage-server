# frozen_string_literal: true

class Api::V1::InventoryItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @inventory_items = current_user.business_unit.inventory_items
    render json: @inventory_items
  end

  def show
    @inventory_item = InventoryItem.find(params[:id])
    render json: @inventory_item
  end

  def create
    @inventory_item = current_user.business_unit.inventory_items.build(inventory_item_params)
    if @inventory_item.save
      render json: @inventory_item, status: :created
    else
      render json: @inventory_item.errors, status: :unprocessable_entity
    end
  end

  def update
    @inventory_item = InventoryItem.find(params[:id])
    if @inventory_item.update(inventory_item_params)
      render json: @inventory_item
    else
      render json: @inventory_item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @inventory_item = InventoryItem.find(params[:id])
    @inventory_item.destroy
    head :no_content
  end

  private

  def inventory_item_params
    params.require(:inventory_item).permit(:name, :quantity, :price, :item_type)
  end
end
