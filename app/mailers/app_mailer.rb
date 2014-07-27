class AppMailer < ActionMailer::Base
  default from: 'no-reply@kepan-flix.com'

  def welcome_mail(user)
    @user = user
    mail(
      to: @user.email,
      subject: "Welcome to register!"
      )
  end

  def reset_password_mail(user)
    @user = user
    @url = "new_password/#{@user.reset_password_token}"
    mail(
      to: @user.email,
      subject: "You are requesting to reset your password."
      )
  end
end