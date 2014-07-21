require 'spec_helper'

feature "queue management" do

  scenario "user adds and re-orders videos to queue" do
    commedy = Fabricate(:category, name: "commedy")
    transformer = Fabricate(:video, categories: [commedy], name: "Transformer")
    monk = Fabricate(:video, name: "Monk", categories: [commedy])
    kongfu = Fabricate(:video, name: "Kong Fu", categories: [commedy])

    # sign_in
    set_current_user

    find("a[href='/videos/#{transformer.id}']").click
    expect(page).to have_content(transformer.name)
    expect(page).to have_link('+ My Queue')

    click_on '+ My Queue'
    expect(page).to have_content(transformer.name)
    expect(page).to have_button("Update Instant Queue")

    click_on transformer.name
    expect(page).not_to have_link('+ My Queue')

    add_video_to_queue(monk)    
    add_video_to_queue(kongfu)

    set_video_position(transformer, 4)
    set_video_position(monk, 3)
    set_video_position(kongfu, 1)
    click_button "Update Instant Queue"

    expect_video_position(transformer, 3)
    expect_video_position(monk, 2)
    expect_video_position(kongfu, 1)

  end

  def expect_video_position(video, position)
    expect(find("input[data-video-id='#{video.id}']").value).to eq(position.to_s)
  end

  def set_video_position(video, position)
    find("input[data-video-id='#{video.id}']").set(position)
  end

  def add_video_to_queue(video)
    visit '/videos'
    find("a[href='/videos/#{video.id}']").click
    click_on '+ My Queue'
  end

end