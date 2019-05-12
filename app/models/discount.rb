class Discount < ApplicationRecord
  validates :kind, inclusion: { in: ["set", "extra"] }
  validates :price, numericality: { greater_than_or_equal_to: 0.0 },
                    allow_nil: true
  validates :count, numericality: { greater_than_or_equal_to: 0 },
                    allow_nil: true

  def as_json(options={})
    if kind == "set"
      options[:only] ||= [:id, :name, :kind, :product_ids, :price]
    else
      options[:only] ||= [:id, :name, :kind, :product_ids, :count]
    end
    super
  end
end

class DiscountProper
  attr_accessor :price, :products, :kind, :name
  
  def degenerate
    dd = DiscountDegenerate.new
    dd.name = @name
    dd.products = @products
    dd.total = @price
    dd
  end 
end

class DiscountDegenerate
  attr_accessor :name, :products, :total
end
