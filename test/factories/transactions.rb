FactoryBot.define do
  factory :transaction do
    amount { "9.99" }
    description { "MyString" }
    transaction_type { "MyString" }
    payment_type { "MyString" }
    business_unit { nil }
  end
end
