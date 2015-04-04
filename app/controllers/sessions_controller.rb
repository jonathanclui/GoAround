class SessionsController < ApplicationController
  
  def new
  end

  def create
      @user = User.from_omniauth(env['omniauth.auth'])
      if @user
          log_in @user
          # params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
          redirect_to root_url
      else
          flash.now[:danger] = 'Invalid credentials from provider'
          render 'new'
      end
  end

  # def create
  #   @user = User.find_by(email: params[:session][:email].downcase)
  #   #if @user && @user.authenticate(params[:session][:password])
  #   if @user
  #         log_in @user
  #         params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
  #         redirect_to root_url
  #   else
  #       flash.now[:danger] = 'Invalid credentials from provider'
  #       render 'new'
  #   end
  # end

  def destroy
    log_out if logged_in?
    flash[:info] = "Successfully Logged Out" unless logged_in?
    redirect_to root_url
  end

end
