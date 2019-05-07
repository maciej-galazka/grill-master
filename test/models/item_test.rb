require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  def setup
    @product = Product.new
    @product.name = "Beer"
    @product.id = 3
    @product.price = 4.57
    @item = @product.build_item(quantity: 4)
  end

  test "shoud be valid" do
    assert @item.valid?
  end

  test "product id should be present" do
    @item.product_id = nil
    assert_not @item.valid?
  end

  test "quantity should be present" do
    @item.quantity = nil
    assert_not @item.valid?
  end

  test "quantity should be greater or equal to 0" do
    @item.quantity = -1
    assert_not @item.valid?
  end
end
