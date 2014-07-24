class WelcomeMailer < ActionMailer::Base
  default from: 'no-reply@kepan-flix.herokuapp.com'

  def welcome_mail(user)
    @user = user
    @url = 'kepan-flix.herokuapp.com/signin'
    mail(
      to: @user.email,
      subject: "Welcome to register!"
      )
  end
end