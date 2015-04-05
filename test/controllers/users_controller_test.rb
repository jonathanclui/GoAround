require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:jorge)
    @other_user = users(:archer)
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should not show user when not logged in" do
    get :show, id: @user
    assert_redirected_to login_url
  end

  test "should show user when logged in" do
    log_in_as(@user)
    get :show, id: @user
    assert_response :success
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to root_url
  end

end
