class ApplicationController < ActionController::API
  def render_items_and_discounts
    items = Item.joins(:product).order(:id).select do |m|
      m.quantity > 0
    end
    discounts = Discount.all
    render json: {"Items" => items.as_json, "Discounts" => discounts.as_json}
  end
end
