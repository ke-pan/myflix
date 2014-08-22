require 'spec_helper'

feature 'User register with credit card charge', { js: true, vcr: true } do
  scenario 'User register successfully with valid personal and credit card info' do
    visit register_path
    fill_in "Email Address", with: "catty@flix.com"
    fill_in "Password", with: "123456"
    fill_in "Full Name", with: "Cat"
    fill_in "Credit Card Number", with: "4242424242424242"
    fill_in "Security Code", with: "123"
    select "8 - August", from: "date-month"
    select '2019', from: 'date-year'
    click_on 'Sign Up'

    expect(page).to have_content "Thank you for your register!"
  end
  scenario 'User register un-successfully with invalid personal info but valid credit card info' do
    visit register_path
    fill_in "Email Address", with: "cat@flix.com"
    fill_in "Password", with: "12"
    fill_in "Full Name", with: "Cat"
    fill_in "Credit Card Number", with: "4242424242424242"
    fill_in "Security Code", with: "123"
    select "8 - August", from: "date-month"
    select '2019', from: 'date-year'
    click_on 'Sign Up'

    expect(page).to have_content "Password is too short"
  end
  scenario 'User register un-successfully with valid personal info but invalid credit card info' do
    visit register_path
    fill_in "Email Address", with: "cit@flix.com"
    fill_in "Password", with: "123456"
    fill_in "Full Name", with: "Cat"
    fill_in "Credit Card Number", with: "4000000000000069"
    fill_in "Security Code", with: "123"
    select "8 - August", from: "date-month"
    select '2019', from: 'date-year'
    click_on 'Sign Up'

    expect(page).to have_content "Your card has expired"
  end
end
