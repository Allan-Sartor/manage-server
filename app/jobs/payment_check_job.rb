# frozen_string_literal: true

class PaymentCheckJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    User.check_payment_statuses
  end
end
