# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def invoice_notification(notification)
    @notification = notification
    @user = @notification.recipient
    mail(to: @user.email, subject: 'Nova Fatura Gerada')
  end
end
