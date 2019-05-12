require_relative 'models/product.rb'
require_relative 'models/item.rb'
require_relative 'models/discount.rb'


class CartTotal
  attr_reader :min_price, :best_discounts, :regular_products, :regular_price

  def initialize
    initialize_items
    initialize_discounts
  end
  def initialize_discounts
    discounts = Discount.all
    @discounts_proper = []
    discounts.each do |discount|
      dp = DiscountProper.new
      dp.kind = discount.kind
      dp.name = discount.name
      if discount.kind == "set"
        dp.price = discount.price
        dp.products = []
        discount.product_ids.each do |product_id|
          dp.products << Product.find(product_id)
        end
      else
        discount.product_ids.each do |product_id|
          dp.products = []
          product = Product.find(product_id)
          (discount.count + 1).times { dp.products << product }
          dp.price = product.price * discount.count
        end
      end
      @discounts_proper << dp
    end
    @discounts_taken = Multiset.new
  end
  def initialize_items
    items = Item.all

    @considered_products = Multiset.new
    items.each do |item|
      @considered_products.add(Product.find(item.product_id), item.quantity)
    end
  end

  def compute_best_discount
    @regular_price = @considered_products.reduce(0.0) { |s,x| s + x.price }
    @min_price = @regular_price
    @best_discounts = Multiset.new
    explore_permutation
    @min_price.round(2)
  end

  def explore_permutation(depth = 0)
    if depth < @discounts_proper.length
      dp = @discounts_proper[depth]
      products_in_discount_locally = Multiset.new
      explore_permutation(depth + 1)
      how_many_dp_taken = 0
      while take_out(dp, products_in_discount_locally)
        @discounts_taken.add(dp)
        how_many_dp_taken += 1
        explore_permutation(depth + 1)
      end
      @considered_products = @considered_products | products_in_discount_locally
      @discounts_taken.delete(dp, how_many_dp_taken)
    else
      price = calculate_price
      if price < @min_price
        @min_price = price
        @best_discounts = @discounts_taken.dup
        @regular_products = @considered_products.dup
      end
    end
  end
  def calculate_price
    price = @discounts_taken.reduce(0) { |s, x| s + x.price }
    price += @considered_products.reduce(0) { |s, x| s + x.price }
    price
  end
  private
  def take_out(dp, products_in_discount)
    local_regular_price = 0.0
    dp.products.each do |product|
      if @considered_products.count(product) > 0
        local_regular_price += product.price
      end
    end
    if local_regular_price <= dp.price
      return false
    end

    some_taken = false
    dp.products.each do |product|
      if @considered_products.count(product) > 0
        @considered_products.delete(product)
        products_in_discount.add(product)
        local_regular_price += product.price
        some_taken = true
      end
    end
    some_taken
  end    
end
