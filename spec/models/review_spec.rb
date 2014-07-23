require 'spec_helper'

describe Review do

  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_presence_of(:rate) }
  it { should validate_presence_of(:description) }
  it { should ensure_inclusion_of(:rate).in_range(1..5) }

  describe "#video_name" do
    it "shows associtated video's name" do
      video = Fabricate(:video)
      review = Fabricate(:review, video: video)
      expect(review.video_name).to eq video.name
    end
  end
  
end