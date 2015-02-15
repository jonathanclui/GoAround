require 'test_helper'

class UserTest < ActiveSupport::TestCase
    
    def setup
        @user = User.new(first_name: "Example",
                        last_name: "LastName",
                        email: "user@example.com",
                        cell: "123456789",
                        address_line_one: "300 Oracle Parkway",
                        city: "Redwood City",
                        state: "CA",
                        zipcode: "94065",
                        password: "foobar", password_confirmation: "foobar")
    end

    # Validation testing for presence of required user fields
    test "Should be valid" do
        assert @user.valid?
    end

    test "First name should be present" do
        @user.first_name = "    "
        assert_not @user.valid?
    end

    test "Last name should be present" do
        @user.last_name = "     "
        assert_not @user.valid?
    end

    test "Email should be present" do
        @user.email = "     "
        assert_not @user.valid?
    end

    test "Cell should be present" do
        @user.cell = "      "
        assert_not @user.valid?
    end

    test "Address line one should be present" do
        @user.address_line_one = "      "
        assert_not @user.valid?
    end

    test "City should be present" do 
        @user.city = "      "
        assert_not @user.valid?
    end

    test "State should be present" do
        @user.state = "     "
        assert_not @user.valid?
    end

    test "Zipcode should be present" do
        @user.zipcode = "   "
        assert_not @user.valid?
    end

    # Validation tests for length of user fields
    test "First name should not be too long" do
        @user.first_name = "a" * 51
        assert_not @user.valid?
    end

    test "Last name should not be too long" do
        @user.last_name = "a" * 51
        assert_not @user.valid?
    end

    test "Email should not be too long" do
        @user.email = "a" * 244 + "@example.com"
        assert_not @user.valid?
    end

    test "Cell should not be longer than 10 numbers" do
        @user.cell = "a"  * 11
        assert_not @user.valid?
    end

    test "Address should not be too long" do
        @user.address_line_one = "a" * 256
        assert_not @user.valid?
    end

    test "City should not be too long" do
        @user.city = "a" * 256
        assert_not @user.valid?
    end

    test "State should not be too long" do
        @user.state = "a" * 256
        assert_not @user.valid?
    end

    test "Zipcode should not be too long" do
        @user.zipcode = "1" * 11
        assert_not @user.valid?
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
    
    # Password Validations
    test "Password should have a minimum length" do 
        @user.password = @user.password_confirmation = "a" * 5
        assert_not @user.valid?
    end

end
