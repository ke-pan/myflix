class ResetPasswordController < ApplicationController

  def send_reset_password_email
    user = User.find_by_email(params[:email])
    if user
      user.generate_reset_password_token
      user.save
      AppMailer.reset_password_mail(user).deliver
    else
      flash[:danger] = "There is some problems about your email."
      redirect_to forget_password_path
    end
  end

  def new_password
    @user = User.find_by(:reset_password_token => params[:token])
    if @user
      @user.generate_reset_password_token
      @user.save
    else
      redirect_to invalid_token_path
    end
  end

  def update_password
    @user= User.find_by(:reset_password_token => params[:token])
    unless @user
      flash[:danger] = "can't find the user in the system."
      redirect_to home_path and return
    end
    @user.password = params[:password]
    if @user.save
      flash[:success] = "Your password has reset successfully!"
      redirect_to signin_path
    else
      render :new_password
    end
  end

end