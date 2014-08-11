def set_current_user(iuser=nil)
  user = iuser || Fabricate(:user)
  session[:user_id] = user.id
end

def set_current_admin(iuser=nil)
  user = iuser || Fabricate(:admin)
  session[:user_id] = user.id
end

def current_user
  @current_user ||= User.find(session[:user_id])
end

def clear_current_user
  session[:user_id] = nil
end

def sign_in(iuser=nil)
  user = iuser || Fabricate(:user)
  visit '/signin'
  fill_in 'Email Address', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Sign In'
end

def last_email
  ActionMailer::Base.deliveries.last
end

def clear_email
  ActionMailer::Base.deliveries.clear
end
