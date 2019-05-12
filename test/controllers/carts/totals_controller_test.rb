require 'test_helper'

class Carts::TotalsControllerTest < ActionDispatch::IntegrationTest
  def setup
    Product.delete_all
    Item.delete_all
    Discount.delete_all
    require_relative "../../../db/seeds.rb"

    beer_id = Product.find_by(name: "Beer").id
    coal_id = Product.find_by(name: "Coal").id
    sausage_id = Product.find_by(name: "Sausage").id
    mustard_id = Product.find_by(name: "Mustard").id

    @beer = Item.create(product_id: beer_id, quantity: 5)
    @coal = Item.create(product_id: coal_id, quantity: 2)
    

    @set = Discount.new
    @set.kind = "set"
    @set.name = "BBQ Pack"
    @set.price = 11.99
    @set.product_ids = [sausage_id, beer_id, beer_id, coal_id]
    @set.count = nil
    @set.save!

    @extra = Discount.new
    @extra.kind = "extra"
    @extra.name = "Three for two"
    @extra.count = 2
    @extra.product_ids = [mustard_id, beer_id]
    @extra.price = nil
    @extra.save!
  end
  test "should return good result for example" do
    get cart_total_url
    assert_response(:success)
    r = JSON.parse(@response.body)
    assert (r['Regular price'] - 34.0).abs < 0.0001
    assert r["Sets"].length == 1
    assert r["Sets"][0]["name"] == "BBQ Pack"
    assert r["Extras"].length == 1
    assert r["Extras"][0]["name"] == "Three for two"
    assert r["Regular products"].length == 1
    assert r["Regular products"][0]["name"] == "Coal"
  end
end
