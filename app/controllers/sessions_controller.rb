class SessionsController < ApplicationController

  before_action :test_logged, only: [:new, :create]
  
  def new
  end
  
  def create
    user = User.find_by(:email => params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome back, #{user.name}"
      redirect_to home_path
    else
      flash[:danger] = "Something wrong about your email or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You logged out!"
    redirect_to root_path
  end

  def test_logged
    redirect_to home_path if logged?
  end

end