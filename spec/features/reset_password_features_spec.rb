require 'spec_helper'

feature 'password reset' do

  given(:alice) do
    Fabricate(:user, name: 'Alice', password: "123456")
  end

  scenario 'reset password by email' do

    visit '/signin'
    click_link 'Forget Password?'

    fill_in "Email Address", with: alice.email
    click_button 'Send Email'

    open_email(alice.email)
    current_email.click_link('Reset your password')

    fill_in "New Password", with: "654321"
    click_button 'Reset Password'

    fill_in 'Email Address', with: alice.email
    fill_in 'Password', with: "654321"
    click_button 'Sign In'
    
    expect(page).to have_content alice.name
  end
end