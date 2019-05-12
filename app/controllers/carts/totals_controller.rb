require_relative '../../cart_total.rb'

class Carts::TotalsController < ApplicationController
  def show
    cart_total = CartTotal.new

    cart_total.compute_best_discount
    sets = cart_total.best_discounts.find_all {|d| d.kind == "set" }
    extras = cart_total.best_discounts.find_all {|d| d.kind == "extra" }
    sets.map!(&:degenerate)
    extras.map!(&:degenerate)
    render json: { "Sets" => sets.as_json, "Extras" => extras.as_json,
                   "Regular products" => cart_total.regular_products,
                   "Regular price" => cart_total.regular_price }
  end
end
