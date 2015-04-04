require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
    
    def setup
        ActionMailer::Base.deliveries.clear
    end

    test "invalid signup information" do
        get signup_path
        assert_no_difference 'User.count' do
            post users_path, user: { first_name: "",
                                     last_name: "",
                                     email: "user@invalid"}
        end
        assert_template 'users/new'
        assert_select 'div#error_explanation'
        assert_select 'div.field_with_errors'
    end

end
