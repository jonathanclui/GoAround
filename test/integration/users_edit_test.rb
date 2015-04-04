require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
    
    def setup
        @user = users(:jorge)
    end

    test "unsuccessful edit" do
        log_in_as(@user)
        get edit_user_path(@user)
        assert_template 'users/edit'
        patch user_path(@user), user: { name: "",
                                        email: "foo@invalid" }
        assert_template 'users/edit'
    end

    test "successful edit" do
        log_in_as(@user)
        get edit_user_path(@user)
        assert_template 'users/edit'
        first_name = "Foo"
        last_name = "bar"
        email = "foo@bar.com"
        patch user_path(@user), user: { first_name: first_name,
                                        last_name: last_name,
                                        email: email }
        assert_not flash.empty?
        assert_redirected_to @user
        @user.reload
        assert_equal @user.first_name, first_name
        assert_equal @user.last_name, last_name
        assert_equal @user.email, email
    end
end
