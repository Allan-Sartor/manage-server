# frozen_string_literal: true

module CnpjGenerator
  def self.generate
    loop do
      cnpj_root = Array.new(8) { rand(0..9) }.join
      cnpj_base = "#{cnpj_root}0001"

      digit_1 = calculate_digit(cnpj_base, [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2])
      digit_2 = calculate_digit("#{cnpj_base}#{digit_1}", [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2])

      cnpj = "#{cnpj_base}#{digit_1}#{digit_2}"

      return cnpj unless BusinessUnit.exists?(cnpj: cnpj)
    end
  end

  def self.calculate_digit(numbers, weights)
    sum = numbers.chars.each_with_index.sum { |char, index| char.to_i * weights[index] }
    remainder = sum % 11
    remainder < 2 ? 0 : 11 - remainder
  end
end
