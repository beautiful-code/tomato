require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get feedbacks" do
    get :feedbacks
    assert_response :success
  end

end
