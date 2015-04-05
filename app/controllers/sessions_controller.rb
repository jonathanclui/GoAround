class SessionsController < ApplicationController
  
  def new
  end

  def create
      @user = User.from_omniauth(env['omniauth.auth'])
      if @user
          log_in @user
          remember @user
          redirect_to root_url
      else
          flash.now[:danger] = 'Invalid credentials from provider'
          render 'new'
      end
  end

  def failure
    flash[:info] = "Failed to Sign In with Uber"
    redirect_to root_url
  end

  def destroy
    log_out if logged_in?
    flash[:info] = "Successfully Logged Out" unless logged_in?
    redirect_to root_url
  end

end
