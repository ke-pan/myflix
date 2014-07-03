class UsersController < ApplicationController

  def front
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Thank you for your register!"
      # binding.pry
      redirect_to home_path
    else
      render :new
    end

  end

  def user_params
    params.require(:user).permit([:name, :email, :password])
  end

end