class AdministratorsController < ApplicationController
  before_action :test_login
  before_action :require_admin

  def require_admin
    unless current_user.admin?
      flash[:danger] = "You can't access there!"
      redirect_to home_path   
    end
  end
end