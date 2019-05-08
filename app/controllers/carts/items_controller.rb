class Carts::ItemsController < ApplicationController
  # POST /cart/items
  def create
    quantity = params[:quantity] ? params[:quantity].to_i : 1
    product_id = params[:product_id]

    if !Product.find(product_id)
      raise "Product not found"
    end
    
    @item = Item.find_by(product_id: product_id)
    if @item 
      @item.quantity += quantity
    else
      @item = Item.create(product_id: product_id, quantity: quantity)
    end
    @item.save


    @items = Item.joins(:product).order(:id).select do |m|
      m.quantity > 0
    end

    render json: @items
  end

  # PATCH /cart/items/1
  # PUT /cart/items/1
  def update
    quantity = params[:quantity].to_i
    @item = Item.find(params[:id])

    @item.quantity = quantity
    @item.save


    @items = Item.joins(:product).select do |m|
      m.quantity > 0
    end

    render json: @items
  end
end
