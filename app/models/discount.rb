class Discount < ApplicationRecord
  def as_json(options={})
    if kind == "set"
      options[:only] ||= [:id, :name, :kind, :product_ids, :price]
    else
      options[:only] ||= [:id, :name, :kind, :product_ids, :count]
    end
    super
  end
end
