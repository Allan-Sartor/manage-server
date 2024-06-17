# frozen_string_literal: true

class Api::V1::TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @transactions = current_user.business_unit.transactions
    render json: @transactions
  end

  def show
    @transaction = Transaction.find(params[:id])
    render json: @transaction
  end

  def create
    @transaction = current_user.business_unit.transactions.build(transaction_params)
    if @transaction.save
      render json: @transaction, status: :created
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  def update
    @transaction = Transaction.find(params[:id])
    if @transaction.update(transaction_params)
      render json: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
    head :no_content
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :description, :transaction_type, :payment_type)
  end
end
