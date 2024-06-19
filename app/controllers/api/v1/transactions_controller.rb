# frozen_string_literal: true

module Api
  module V1
    class TransactionsController < ApplicationController
      before_action :authenticate_api_user!
      before_action :set_current_business_unit

      def index
        @transactions = @current_business_unit.transactions
        render json: @transactions
      end

      def show
        @transaction = @current_business_unit.transactions.find(params[:id])
        render json: @transaction
      end

      def create
        @transaction = @current_business_unit.transactions.build(transaction_params)

        if @transaction.transaction_scope == 'venda' && @transaction.inventory_item.present? && !valid_inventory_item?(@transaction)
          render json: { error: 'Insufficient inventory for the selected item.' }, status: :unprocessable_entity
          return
        end

        if @transaction.save
          render json: @transaction, status: :created
        else
          render json: @transaction.errors, status: :unprocessable_entity
        end
      end

      def update
        @transaction = @current_business_unit.transactions.find(params[:id])
        if @transaction.update(transaction_params)
          render json: @transaction
        else
          render json: @transaction.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @transaction = @current_business_unit.transactions.find(params[:id])
        @transaction.destroy
        head :no_content
      end

      private

      def transaction_params
        params.require(:transaction).permit(:amount, :description, :transaction_type, :payment_type, :status, :client_id, :inventory_item_id, :transaction_scope)
      end

      def set_current_business_unit
        @current_business_unit = if current_api_user.can_create_business_unit? && params[:business_unit_id].present?
                                   current_api_user.business_units.find(params[:business_unit_id])
                                 else
                                   current_api_user.business_units.first
                                 end
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Business unit not found' }, status: :not_found
      end

      def valid_inventory_item?(transaction)
        inventory_item = transaction.inventory_item
        inventory_item.present? && inventory_item.quantity >= transaction.amount
      end
    end
  end
end
