class UsersController < ApplicationController

  before_action :test_login, only: :show

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      WelcomeMailer.welcome_mail(@user).deliver
      session[:user_id] = @user.id
      flash[:success] = "Thank you for your register!"
      redirect_to home_path
    else
      render :new
    end

  end

  def show
    @user = User.find(params[:id])
    # binding.pry
  end

  def user_params
    params.require(:user).permit([:name, :email, :password])
  end

end