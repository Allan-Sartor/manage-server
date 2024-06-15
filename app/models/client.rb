class Client < ApplicationRecord
  belongs_to :business_unit

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
