# frozen_string_literal: true

module Api
  module V1
    class PaymentsController < ApplicationController
      before_action :authenticate_api_user!

      def create
        payment_service = PaymentService.new(current_user, payment_params)
        result = payment_service.process_payment

        if result[:status] == 'approved'
          render json: { status: 'success', payment_id: result[:payment_id] }
        else
          render json: { status: 'failure', error: result[:error] }, status: :unprocessable_entity
        end
      end

      private

      def payment_params
        params.require(:payment).permit(:amount, :description, :payment_method_id, :email, :identification_type, :identification_number, :token, :installments)
      end
    end
  end
end
