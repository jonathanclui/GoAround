require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
    include ApplicationHelper

    def setup
        @user = users(:jorge)
    end

    test "profile display" do
        get user_path(@user)
        assert_template 'users/show'
        assert_select 'title', full_title(@user.first_name)
        assert_select 'h1', text: @user.first_name
        assert_select 'h1>img.gravatar'
        assert_match @user.travel_routes.count.to_s, response.body
        assert_select 'div.pagination'
        @user.travel_routes.paginate(page: 1).each do |travel_route|
            assert_match travel_route.distance.to_s, response.body
        end
    end
end
