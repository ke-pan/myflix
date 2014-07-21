class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged?
    !!current_user
  end

  def test_login
    unless logged?
      flash[:success] = "Only member can access, please sign up!"
      redirect_to register_path
    end
  end

  def current_user_has?(something)
    something.user == current_user
  end

end
