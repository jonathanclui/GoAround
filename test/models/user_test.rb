require 'test_helper'

class UserTest < ActiveSupport::TestCase
    
    def setup
        @user = User.new(   provider: "uber",
                            uid: "109230194809853JKDJFLKAJF",
                            email: "user@example.com",
                            first_name: "Jorge",
                            last_name: "Colmo",
                            picture: "https://testpicture.com",
                            promo_code: "A123DFA",
                            oauth_token: "120390dfajslfnandasljfklsajk",
                            refresh_token: "DKJFLAKDFJ-dasjfkljdlkfj-asfdkl")
    end

    # Validation testing for presence of required user fields
    test "Should be valid" do
        assert @user.valid?
    end

    # E-mail Format Validation
    test "Email validation should accept valid addresses" do
        valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |valid_address|
            @user.email = valid_address
            assert @user.valid?, "#{valid_address.inspect} should be valid"
        end
    end

    test "Email validation should reject invalid addresses" do
        invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar..com]
        invalid_addresses.each do |invalid_address|
            @user.email = invalid_address
            assert_not @user.valid?, "#{invalid_address.inspect} should be valid"
        end
    end

    test "Email addresses should be saved as lower-case" do
        mixed_case_email = "Foo@ExAMPLe.CoM"
        @user.email = mixed_case_email
        @user.save
        assert_equal mixed_case_email.downcase, @user.reload.email
    end

    # E-mail Uniqueness Validation
    test "Email addresses should be unique" do
        duplicate_user = @user.dup
        duplicate_user.email = @user.email.upcase
        @user.save
        assert_not duplicate_user.valid?
    end
    
    # Authentication Tests
    test "authenticated? should return false for a user with nil digest" do
        assert_not @user.authenticated?(:remember, '')
    end

    # Routes Tests
    test "associated routes should be destroyed" do
        @user.save
        @user.travel_routes.create!(start_long: -122.123, start_lat: 32.123, end_long: -122.235, end_lat: 32.923, distance: 8.92, price: 8.24)
        assert_difference 'TravelRoute.count', -1 do
            @user.destroy
        end
    end

    # Relationship tests
    test "should follow and unfollow a user" do
        jorge = users(:jorge)
        archer = users(:archer)
        assert_not jorge.following?(archer)
        jorge.follow(archer)
        assert jorge.following?(archer)
        assert archer.followers.include?(jorge)
        jorge.unfollow(archer)
        assert_not jorge.following?(archer)
    end

    test "feed should have the right posts" do
        jorge = users(:jorge)
        archer = users(:archer)
        lana = users(:lana)
        # Travel routes from followed user
        lana.travel_routes.each do |route_following|
            assert jorge.feed.include?(route_following)
        end
        # Travel routes from self
        jorge.travel_routes.each do |route_self|
            assert jorge.feed.include?(route_self)
        end
        # Travel routes from unfollowed user
        archer.travel_routes.each do |route_unfollowed|
            assert_not jorge.feed.include?(route_unfollowed)
        end
    end
end
