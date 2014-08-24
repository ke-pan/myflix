class UserRegister
  attr_reader :message, :user_id
  def initialize(user_info, card_token, invitation_token)
    @user_info = user_info
    @card_token = @card_token
    @invitation_token = invitation_token
  end

  def register
    begin
      User.transaction do
        @user = User.create!(@user_info)
        StripeWrapper::Charge.charge(
          :email       => @user.email,
          :token       => @card_token,
          :description => "charge of signup #{@user.email}",
          :amount      => 999
        )
      end
      if valid_token?
        inviter = @invitation.user
        Followship.create(user_id: inviter.id, followee_id: @user.id)
        Followship.create(user_id: @user.id, followee_id: inviter.id)
        @invitation.destroy
      end
      WelcomeWorker.perform_async(@user.id)
      @status = true
      @message = "Thank you for your register!"
      @user_id = @user.id
    rescue Stripe::CardError, ActiveRecord::RecordInvalid => e
      @status = false
      @message = e.message
    end
    self
  end

  def successful?
    @status
  end
  private
  def valid_token?
    @invitation_token.present? && @invitation = Invitation.find_by_token(@invitation_token)
  end
end
