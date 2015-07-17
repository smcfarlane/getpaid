require 'test_helper'

class InvitesControllerTest < ActionController::TestCase
  test "should get invite_vendor" do
    get :invite_vendor
    assert_response :success
  end

  test "should get invite_client" do
    get :invite_client
    assert_response :success
  end

end
