# frozen_string_literal: true

module Api
  module V1
    class ClientsController < ApplicationController
      before_action :authenticate_api_user!
      before_action :set_client, only: [:show, :update, :destroy]

      def index
        @clients = current_api_user.business_unit.clients
        render json: @clients
      end

      def show
        render json: @client
      end

      def create
        @client = current_api_user.business_unit.clients.build(client_params)
        if @client.save
          render json: { client: @client, message: 'Client created successfully' }, status: :created
        else
          render json: { errors: @client.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @client.update(client_params)
          render json: { client: @client, message: 'Client updated successfully' }
        else
          render json: { errors: @client.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @client.destroy
        render json: { message: 'Client deleted successfully' }, status: :no_content
      end

      private

      def set_client
        @client = current_api_user.business_unit.clients.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Client not found' }, status: :not_found
      end

      def client_params
        params.require(:client).permit(:name, :email)
      end
    end
  end
end
