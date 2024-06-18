# frozen_string_literal: true

module CnpjValidator
  extend ActiveSupport::Concern

  included do
    validate :cnpj_must_be_valid
  end

  def self.normalize(cnpj)
    cnpj.to_s.gsub(/[^0-9]/, '')
  end

  private

  def cnpj_must_be_valid
    return if valid_cnpj?(cnpj)

    errors.add(:cnpj, 'is not a valid CNPJ')
  end

  def valid_cnpj?(cnpj)
    cnpj = CnpjValidator.normalize(cnpj)
    return false if cnpj.length != 14

    numbers = cnpj[0..11].chars.map(&:to_i)
    digits = cnpj[12..13].chars.map(&:to_i)

    valid_digits?(numbers, digits)
  end

  def valid_digits?(numbers, digits)
    first_digit = calculate_digit(numbers, [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2])
    second_digit = calculate_digit(numbers + [first_digit], [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2])

    digits == [first_digit, second_digit]
  end

  def calculate_digit(numbers, weights)
    sum = numbers.zip(weights).sum { |number, weight| number * weight }

    remainder = sum % 11

    remainder < 2 ? 0 : 11 - remainder
  end
end
