class CartsController < ApplicationController
  def show
    @items = Item.joins(:product)
    render json: @items
  end
end
