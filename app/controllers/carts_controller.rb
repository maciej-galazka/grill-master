class CartsController < ApplicationController
  def show
    @items = Item.where("quantity > ?", 0)
    @discounts = Discount.all
    render json: {"Items" => @items.as_json, "Discounts" => @discounts.as_json}
  end
end
