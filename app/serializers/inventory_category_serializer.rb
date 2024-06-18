class InventoryCategorySerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :business_unit
end
