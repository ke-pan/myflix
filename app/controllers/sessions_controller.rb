class SessionsController < ApplicationController
  
  def new
    redirect_to home_path if logged?
  end
  
  def create   
    user = User.find_by(:email => params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome back, #{user.name}"
      redirect_to home_path
    else
      flash[:danger] = "Something wrong about your email or password"
      redirect_to signin_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You logged out!"
    redirect_to root_path
  end

end