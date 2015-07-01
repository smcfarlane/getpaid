require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get features" do
    get :features
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

end
