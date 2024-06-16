# frozen_string_literal: true

class MonthlyPaymentJob < ApplicationJob
  queue_as :default

  def perform
    BusinessUnit.generate_monthly_payments
  end
end
