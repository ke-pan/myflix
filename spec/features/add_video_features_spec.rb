require 'spec_helper'

feature "admin adds a new video" do
  scenario "admin successfully adds a new video" do
    Fabricate(:category, name: 'Drama')
    Fabricate(:category, name: 'Education')

    admin = Fabricate(:admin)
    sign_in(admin)

    visit new_admin_video_path
    fill_in 'Title', with: 'Transformer'
    select 'Drama', from: 'video_category_ids'
    fill_in 'Description', with: 'Awesome video!'
    attach_file 'Large cover', File.join(Rails.root, 'public/tmp/monk_large.jpg')
    attach_file 'Small cover', File.join(Rails.root, 'public/tmp/monk.jpg')
    fill_in 'Video url', with: 'www.test.com/example.mp4'

    click_button 'Add Video'

    expect(page).to have_content 'Transformer'
    expect(page).to have_selector "img[src='/uploads/video/large_cover/1/monk_large.jpg']"
    expect(page).to have_selector "a[href='www.test.com/example.mp4']"

  end
end
