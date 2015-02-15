require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
    
    test "invalid signup information" do
        get signup_path
        assert_no_difference 'User.count' do
            post users_path, user: { first_name: "",
                                     last_name: "",
                                     email: "user@invalid",
                                     password: "foo",
                                     password_confirmation: "bar",
                                     cell: "",
                                     address_line_one: "",
                                     city: "",
                                     state: "",
                                     zipcode: "" }
        end
        assert_template 'users/new'
        assert_select 'div#error_explanation'
        assert_select 'div.field_with_errors'
    end

    test "valid signup information" do
        get signup_path
        assert_difference 'User.count', 1 do
            post_via_redirect users_path, user: { first_name: "Example",
                                                  last_name: "User",
                                                  email: "user@example.com",
                                                  password: "password",
                                                  password_confirmation: "password",
                                                  cell: "6172125121",
                                                  address_line_one: "77 Mass Ave.",
                                                  city: "Cambridge",
                                                  state: "MA",
                                                  zipcode: "02139" }
        end
        assert_template 'users/show'
        assert_not flash.empty?
    end

end
