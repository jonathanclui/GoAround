require 'test_helper'

class TravelRouteTest < ActiveSupport::TestCase
    
    def setup
        @user = users(:jorge)
        @travel_route = @user.travel_routes.build(start_lat: -122.51, end_lat: 32.51, start_long: -122.592, end_long: 32.923, distance: 8.21, price: 7.21)
    end

    test "should be valid" do
        assert @travel_route.valid?
    end

    # Presence Validations
    test "user id should be present" do
        @travel_route.user_id = nil
        assert_not @travel_route.valid?
    end

    test "start latitude should be present" do
        @travel_route.start_lat = " "
        assert_not @travel_route.valid?
    end

    test "end latitude should be present" do
        @travel_route.end_lat = " "
        assert_not @travel_route.valid?
    end

    test "start longitude should be present" do
        @travel_route.start_long = " "
        assert_not @travel_route.valid?
    end

    test "distance should be present" do
        @travel_route.distance = " "
        assert_not @travel_route.valid?
    end

    test "price should be present" do
        @travel_route.price = " "
        assert_not @travel_route.valid?
    end

    test "order should be most recent first" do
        assert_equal TravelRoute.first, travel_routes(:most_recent)
    end

end
