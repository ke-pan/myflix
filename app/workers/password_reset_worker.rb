class PasswordResetWorker
  include Sidekiq::Worker
  def perform(user_id)
    user = User.find user_id
    AppMailer.reset_password_mail(user).deliver
  end
end