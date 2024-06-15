FactoryBot.define do
  factory :inventory_item do
    name { "MyString" }
    quantity { 1 }
    price { "9.99" }
    item_type { "MyString" }
    business_unit { nil }
  end
end
