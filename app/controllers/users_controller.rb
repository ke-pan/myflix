class UsersController < ApplicationController

  before_action :test_login, only: :show

  def new
    if valid_token?
      @user = User.new(email: @invitation.email, name: @invitation.name)
    else
      @user = User.new
    end
  end

  def create
    begin
      User.transaction do
        @user = User.create!(user_params)
        StripeWrapper::Charge.charge(
          :email       => @user.email,
          :token       => params[:stripeToken],
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
      session[:user_id] = @user.id
      flash[:success] = "Thank you for your register!"
      redirect_to home_path
    rescue Stripe::CardError, ActiveRecord::RecordInvalid => e
      flash[:danger] = e.message
      redirect_to register_path
    end

  end

  def show
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit([:name, :email, :password])
  end

  def valid_token?
    params[:token].present? && @invitation = Invitation.find_by_token(params[:token])
  end

end
