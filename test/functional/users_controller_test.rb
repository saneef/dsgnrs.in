require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get apply" do
    get :apply
    assert_response :success
  end

end
