class Item < ApplicationRecord
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :product_id, presence: true

  belongs_to :product

  def as_json(options={})
    options[:only] ||= [:id, :quantity]
    options[:include] ||= {product: { only: [:id, :name, :price] } }
    super
  end
end
