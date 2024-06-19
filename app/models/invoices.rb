# frozen_string_literal: true

class Invoice < ApplicationRecord
  after_create :notify_user

  private

  def notify_user
    InvoiceNotification.with(invoice: self).deliver_later(user)
  end
end
