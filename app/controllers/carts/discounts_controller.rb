class Carts::DiscountsController < ApplicationController
  # POST /cart/discounts
  def create 
    if params[:kind] != "extra" && params[:kind] != "set"
      raise "Invalid argument"
    end
    @discount = Discount.new
    @discount.kind = params[:kind]
    @discount.name = params[:name]
    @discount.product_ids = params[:product_ids][1..-2].split(',').map(&:to_i)
    if @discount.kind == "set"
      @discount.price = params[:price]
    else
      @discount.count = params[:count]
    end
    @discount.save
  end
  # PUT /cart/discounts/1
  # PATCH /cart/discounts/1
  def update
    @discount = Discount.find(params[:id])
    if params[:kind] != "extra" && params[:kind] != "set" && 
       params[:kind] != nil
      raise "Invalid argument"
    end
    @discount.kind = params[:kind] if params[:kind] != nil
    @discount.name = params[:name] if params[:name] != nil
    if params[:product_ids] != nil
      @discount.product_ids = params[:product_ids][1..-2].split(',').map(&:to_i)
    end
    if @discount.kind == "set"
      @discount.price = params[:price] if params[:price] != nil
      @discount.count = nil
    elsif @discount.kind == "extra"
      @discount.price = nil 
      @discount.count = params[:count] if params[:count] != nil
    end

    @discount.save
  end
  
end
