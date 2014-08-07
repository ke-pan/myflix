class WelcomeWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find user_id
    AppMailer.welcome_mail(user).deliver
  end

end