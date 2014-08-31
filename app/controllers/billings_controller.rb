class BillingsController < ApplicationController
  before_action :test_login

  def index
    @user = User.find(params[:user_id]).decorate
    unless @user == current_user || current_user.admin?
      flash[:danger] = "You don't have the access permission!"
      redirect_to home_path and return
    end
    @billings = @user.billings.decorate
  end
end
