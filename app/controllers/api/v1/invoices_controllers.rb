# frozen_string_literal: true

module Api
  module V1
    class InvoicesController < ApplicationController
      before_action :authenticate_api_user!

      def create
        @invoice = current_api_user.invoices.build(invoice_params)
        if @invoice.save
          InvoiceNotification.with(invoice: @invoice).deliver_later(current_user)
          render json: @invoice, status: :created
        else
          render json: @invoice.errors, status: :unprocessable_entity
        end
      end

      private

      def invoice_params
        params.require(:invoice).permit(:amount, :details)
      end
    end
  end
end
