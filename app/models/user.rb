# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include DeviseTokenAuth::Concerns::User

  belongs_to :plan
  has_one :business_unit, dependent: :destroy

  after_create :set_initial_payment_due_date

  def set_initial_payment_due_date
    update(payment_due_date: 7.days.from_now)
  end

  def active?
    payment_status == 'paid' && payment_due_date > Time.current
  end

  def self.check_payment_statuses
    where(payment_due_date: ...Time.current).where(payment_status: 'paid').find_each do |user|
      user.update(payment_status: 'overdue')
      UserMailer.payment_overdue(user).deliver_later
    end

    where(payment_due_date: ...7.days.ago).where(payment_status: 'overdue').find_each do |user|
      user.update(payment_status: 'canceled')
      user.business_unit.update(active: false)
      UserMailer.service_canceled(user).deliver_later
    end
  end
end
