ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Returns ture if a test user is logged in.
  def is_logged_in?
    !session[:user_id].nil?
  end

  # Logs in a test user
  def log_in_as(user, options = {})
    if integration_test?
        post login_path, session: { email:          user.email, 
                                    first_name:     user.first_name, 
                                    last_name:      user.last_name, 
                                    provider:       user.provider, 
                                    uid:            user.uid,
                                    promo_code:     user.promo_code,
                                    oauth_token:    user.oauth_token,
                                    refresh_token:  user.refresh_token,
                                    picture:        user.picture }
    else
        session[:user_id] = user.id
    end
  end

  private
    
    # Returns true inside an integration test.
    def integration_test?
        defined?(post_via_redirect)
    end
end
