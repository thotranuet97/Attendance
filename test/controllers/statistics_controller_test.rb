require 'test_helper'

class StatisticsControllerTest < ActionController::TestCase
  test "should get total" do
    get :total
    assert_response :success
  end

end
