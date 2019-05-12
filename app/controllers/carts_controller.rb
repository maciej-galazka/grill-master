class CartsController < ApplicationController
  def show
    render_items_and_discounts
  end
end
