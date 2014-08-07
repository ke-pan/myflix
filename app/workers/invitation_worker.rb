class InvitationWorker
  include Sidekiq::Worker

  def perform(user_id, invitation_id)
    user = User.find user_id
    invitation = Invitation.find invitation_id
    AppMailer.invitation_mail(user, invitation).deliver
  end
end