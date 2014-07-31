class InvitationsController < ApplicationController
  before_action :test_login

  def new
    @invitation = Invitation.new
  end

  def create
    if User.exists?(email: invitation_params[:email])
      flash[:danger] = "The email is already in system."
      redirect_to invite_path and return
    end
    @invitation = current_user.invitations.build(invitation_params)
    if @invitation.save
      AppMailer.invitation_mail(current_user, @invitation).deliver
      redirect_to invitation_confirm_path
    else
      render :new
    end
  end

  def invitation_params
    params.require(:invitation).permit([:name, :email, :message])
  end
end