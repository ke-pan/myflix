require 'spec_helper'

feature 'sign in' do
  background do
    alice = Fabricate(:user, name: "Alice", password: 'password', email: 'alice@test.com')
  end

  scenario 'with valid inputs' do
    visit '/signin'
    fill_in 'Email Address', with: 'alice@test.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'
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

end