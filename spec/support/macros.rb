def set_current_user
  user = Fabricate(:user)
  session[:user_id] = user.id
end

def current_user
  @current_user ||= User.find(session[:user_id])
end

def sign_in(iuser=nil)
  user = iuser || Fabricate(:user)
  visit '/signin'
  fill_in 'Email Address', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Sign In'
end