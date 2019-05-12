class Product < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  has_one :item

  def as_json(options={})
    options[:only] ||= [:name, :price, :id]
    super
  end
end
