# frozen_string_literal: true

module Api
  module V1
    class NotificationsController < ApplicationController
      before_action :authenticate_api_user!

      def index
        @notifications = current_api_user.notifications
        render json: @notifications
      end

      def mark_as_read
        @notification = current_api_user.notifications.find(params[:id])
        @notification.update(read: true)
      end
    end
  end
end
