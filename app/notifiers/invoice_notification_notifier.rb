# frozen_string_literal: true

class InvoiceNotification < Noticed::Base
  deliver_by :database
  deliver_by :email, mailer: 'NotificationMailer'

  param :invoice

  def message
    'Uma nova fatura foi gerada.'
  end

  def url
    Rails.application.routes.url_helpers.invoice_url(params[:invoice])
  end
end
