require 'spec_helper'

feature 'sign in' do
  given(:alice) do
    Fabricate(:user, name: "Alice", password: 'password', email: 'alice@test.com')
  end

  scenario 'with valid inputs' do
    sign_in(alice)
    page.should have_content('Alice')
    page.should have_content('Welcome back')
  end

  scenario 'with invalid inputs' do
    visit 'signin'
    fill_in 'Email Address', with: 'alice@test.com'
    fill_in 'Password', with: 'wrong password'
    click_button 'Sign In'
    page.should have_content('Something wrong about your email or password')
  end

  scenario 'with deactivated user' do
    bob = Fabricate(:user, active: false)
    sign_in(bob)
    page.should have_content('Your acount was locked, please contact customer service.')
  end

end
