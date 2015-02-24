require 'test_helper'

class TravelRoutesControllerTest < ActionController::TestCase
    
    def setup
        @travel_route = travel_routes(:travel_route_one)
    end

    test "should redirect create when not logged in" do
        assert_no_difference 'TravelRoute.count' do
            post :create, travel_route: { start_lat: -122.3213, end_lat: -122.513, start_long: 32.12312, end_long: 32.5213, distance: 8.92, price: 28.92 }
        end
        assert_redirected_to login_url
    end
    
    test "should redirect destroy when not logged in" do
        assert_no_difference 'TravelRoute.count' do
            delete :destroy, id: @travel_route
        end
        assert_redirected_to login_url
    end

    test "should redirect destroy for wrong travel route" do
        log_in_as(users(:jorge))
        temp_route = travel_routes(:most_recent)
        assert_no_difference 'TravelRoute.count' do
            delete :destroy, id: temp_route
        end
        assert_redirected_to root_url
    end

end
