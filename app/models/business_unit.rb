# frozen_string_literal: true

class BusinessUnit < ApplicationRecord
  include CnpjValidator

  # Associações
  belongs_to :user
  belongs_to :plan
  has_many :clients, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :inventory_items, dependent: :destroy

  # Callbacks
  before_validation :normalize_cnpj
  
  # Callbacks
  after_create :set_initial_payment_due_date, :set_trial_period
  before_destroy :check_for_associated_records

  # Validações
  validates :name, presence: true
  validates :cnpj, presence: true, uniqueness: { scope: :user_id }, on: :create
  validates :state_registration, presence: true
  validates :municipal_registration, presence: true
  validates :legal_name, presence: true
  validates :trade_name, presence: true
  validate :cnpj_must_be_valid

  def normalize_cnpj
    self.cnpj = CnpjValidator.normalize(cnpj)
  end

  def set_initial_payment_due_date(payment_due_day = nil)
    duration = case plan.periodicity
               when 'annual'
                 1.year.from_now
               when 'monthly'
                 1.month.from_now
               else
                 14.days.from_now
               end
    due_date = payment_due_day ? duration.change(day: payment_due_day) : duration
    update(payment_due_date: due_date, notification_date: due_date - 15.days)
  end

  def set_trial_period
    update(trial_end_date: 14.days.from_now) if plan.name == 'Trial'
  end

  def active?
    return false if trial_end_date && trial_end_date < Time.current

    payment_status == 'paid' && payment_due_date > Time.current
  end

  def check_payment_status
    return unless payment_due_date < Time.current

    update(payment_status: 'overdue') if payment_status == 'paid'
    return unless payment_due_date < 15.days.ago

    update(payment_status: 'suspended')
    UserMailer.service_suspended(user).deliver_later
  end

  def self.generate_monthly_payments
    find_each do |business_unit|
      next unless business_unit.payment_due_date <= Time.current

      payment_service = PaymentService.new(business_unit, {
                                             amount: business_unit.plan.price,
                                             description: "Subscription for #{business_unit.plan.name}",
                                             payment_method_id: 'pix',
                                             email: business_unit.user.email,
                                             identification_type: 'CPF',
                                             identification_number: business_unit.user.cpf,
                                             token: business_unit.user.payment_token,
                                             installments: 1
                                           })

      result = payment_service.process_payment

      if result[:status] == 'approved'
        duration = business_unit.plan.duration == 'annual' ? 1.year.from_now : 1.month.from_now
        business_unit.update(payment_status: 'paid', payment_due_date: duration, notification_date: duration - 15.days)
      else
        business_unit.update(payment_status: 'payment_failed')
        UserMailer.payment_failed(business_unit.user, result[:error]).deliver_later
      end
    end
  end

  def total_income
    transactions.income.sum(:amount)
  end

  def total_expense
    transactions.expense.sum(:amount)
  end

  def total_compra
    transactions.compra.sum(:amount)
  end

  def total_venda
    transactions.venda.sum(:amount)
  end

  def total_despesa
    transactions.despesa.sum(:amount)
  end

  def total_receita
    transactions.receita.sum(:amount)
  end

  def total_transactions_by_payment_type(payment_type)
    transactions.where(payment_type: payment_type).sum(:amount)
  end

  def total_transactions_by_scope(transaction_scope)
    transactions.where(transaction_scope: transaction_scope).sum(:amount)
  end

  private

  def check_for_associated_records
    if transactions.exists? || clients.exists?
      errors.add(:base, 'Cannot delete business unit with associated transactions or clients.')
      throw(:abort)
    end

    return unless user.business_units.count == 1

    errors.add(:base, 'Cannot delete the only business unit.')
    throw(:abort)
  end
end
