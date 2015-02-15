require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "GoAround - Home | Compare.Request.Ride"
  end

  test "should get help" do
    get :help
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "GoAround - Contact | Compare.Request.Ride"
  end

  test "should get jobs" do
    get :jobs
    assert_response :success
    assert_select "title", "GoAround - Jobs | Compare.Request.Ride"
  end
end
