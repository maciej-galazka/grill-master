require 'test_helper'

class DiscountTest < ActiveSupport::TestCase
  def setup
    @set = Discount.new
    @set.kind = "set"
    @set.name = "BBQ Pack"
    @set.price = 11.99
    @set.product_ids = [4,5,5,8]
    @set.count = nil

    @extra = Discount.new
    @extra.kind = "extra"
    @extra.name = "Three for two"
    @extra.count = 2
    @extra.product_ids = [3, 5]
    @extra.price = nil
  end

  test "shoud be valid" do
    assert @set.valid?
    assert @extra.valid?
  end

  test "kind should be set or extra" do
    @set.kind ="other kind"
    assert_not @set.valid?
  end

  test "price should be greater than or equal to 0" do
    @set.price = "-0.01"
    assert_not @set.valid?
  end

  test "count should be greater than or equal to 0" do
    @extra.count = -1
    assert_not @extra.valid?
  end
end
