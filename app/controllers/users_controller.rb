class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :destroy, :following, :followers]
  before_action :admin_user, only: :destroy

  # GET /users
  # GET /users.json
  def index
    @users = User.all.paginate(page: params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        log_in @user
        flash[:info] = "Account successfully created!"
        format.html { redirect_to root_url }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(user_params)
        flash[:success] = 'Profile was successfully updated.'
        format.html { redirect_to @user }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    User.find(params[:id]).destroy
    respond_to do |format|
      flash[:success] = 'User was succesfully destroyed.'
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:provider, :uid, :email, :first_name, :last_name, :picture, :promo_code, :oauth_token, :refresh_token)
    end

    # Confirms the correct user.
    def correct_user
        @user = User.find(params[:id])
        redirect_to(root_url) unless current_user?(@user) 
    end

    # Confirms an admin user.
    def admin_user
        redirect_to(root_url) unless current_user.admin?
    end
end
