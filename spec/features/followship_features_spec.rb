require 'spec_helper'

feature "followship management" do
  scenario "user follows and unfollows people" do
    drama = Fabricate(:category, name: "Drama")
    trafic = Fabricate(:video, name: "Trafic", categories: [drama])
    kongfu = Fabricate(:video, name: "Kong Fu", categories: [drama])

    alice = Fabricate(:user)
    bob = Fabricate(:user)
    eve = Fabricate(:user)

    bob_review = Fabricate(:review, video: trafic, user: bob)
    eve_review = Fabricate(:review, video: kongfu, user: eve)

    sign_in(alice)

    visit '/home'
    find("a[href='/videos/#{trafic.id}']").click
    expect(page).to have_content(bob.name)

    find("a[href='/users/#{bob.id}']").click
    expect(page).to have_link("Follow")

    click_link "Follow"
    expect(page).to have_content("You successfully follow #{bob.name}")

    click_link "People"
    expect(page).to have_content(bob.name)

    find(:xpath, "//tr[contains(.,'#{bob.name}')]//a[@data-method='delete']").click
    expect(page).not_to have_content(bob.name)

  end

end