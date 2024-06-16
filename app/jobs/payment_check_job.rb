# frozen_string_literal: true

class PaymentCheckJob < ApplicationJob
  queue_as :default

  def perform
    BusinessUnit.find_each(&:check_payment_status)
  end
end
