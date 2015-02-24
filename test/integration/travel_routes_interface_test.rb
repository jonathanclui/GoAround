require 'test_helper'

class TravelRoutesInterfaceTest < ActionDispatch::IntegrationTest
    
    def setup
        @user = users(:jorge)
    end

    test "travel routes interface" do
        log_in_as(@user)
        get root_path
        assert_select 'div.pagination'
        # Invalid submission
        assert_no_difference 'TravelRoute.count' do
            post travel_routes_path, travel_route: { start_lat:  "" }
        end
        assert_select 'div#error_explanation'
        # Valid submission
        start_lat = -122.3213
        end_lat = -122.32534
        start_long = 32.1235
        end_long = 32.59123
        distance = 22.1
        price = 33.72
        assert_difference 'TravelRoute.count', 1 do
            post travel_routes_path, travel_route: {    start_lat: start_lat,
                                                        end_lat: end_lat,
                                                        start_long: start_long,
                                                        end_long: end_long,
                                                        distance: distance,
                                                        price: price }
        end
        assert_redirected_to root_url
        follow_redirect!
        assert_match distance.to_s, response.body
        # Delete a post.
        assert_select 'a', text: 'delete'
        first_travel_route = @user.travel_routes.paginate(page: 1).first
        assert_difference 'TravelRoute.count', -1 do
            delete travel_route_path(first_travel_route)
        end
        # Visit a different user.
        get user_path(users(:archer))
        assert_select 'a', text: 'delete', count: 0
    end
end
