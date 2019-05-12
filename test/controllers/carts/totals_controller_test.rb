require 'test_helper'

class Carts::TotalsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get carts_totals_show_url
    assert_response :success
  end

end
