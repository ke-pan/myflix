class UsersController < ApplicationController

  before_action :test_login, only: :show

  def new
    if valid_token?
      @user = User.new(email: @invitation.email, name: @invitation.name)
    else
      @user = User.new
    end
  end

  def create
    register = UserRegister.new(user_params, params[:stripeToken], params[:token]).register
    if register.successful?
      session[:user_id] = register.user_id
      flash[:success] = register.message
      redirect_to home_path
    else
      flash[:danger] = register.message
      redirect_to register_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit([:name, :email, :password])
  end

  def valid_token?
    params[:token].present? && @invitation = Invitation.find_by_token(params[:token])
  end

end
