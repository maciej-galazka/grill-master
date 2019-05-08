class ItemSerializer < ActiveModel::Serializer
  has_one :product
  attributes :id, :quantity
end
