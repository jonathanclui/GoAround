require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:jorge)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { address_line_one: @user.address_line_one, address_line_two: @user.address_line_two, cell: @user.cell, city: @user.city, email: "test3@yahoo.com", first_name: @user.first_name, last_name: @user.last_name, state: @user.state, zipcode: @user.zipcode, password: "foobar", password_confirmation: "foobar" }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { address_line_one: @user.address_line_one, address_line_two: @user.address_line_two, cell: @user.cell, city: @user.city, email: "testUpdate@yahoo.com", first_name: @user.first_name, last_name: @user.last_name, state: @user.state, zipcode: @user.zipcode, password: "foobar", password_confirmation: "foobar" }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
