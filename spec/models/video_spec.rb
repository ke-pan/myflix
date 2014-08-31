require 'spec_helper'

describe Video do

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }

  it { should have_many(:categories) }
  it { should have_many(:reviews) }
  it { should have_many(:queue_items) }

  describe "#search_by_title" do
    before do
      @video1 = Fabricate(:video, name: "my video1")
      @video2 = Fabricate(:video, name: "my video2")
    end

    it "returns an array of object which title contains the string" do
      expect(Video.search_by_title("video")).to eq([@video1, @video2])
      expect(Video.search_by_title("o1")).to eq([@video1])
      expect(Video.search_by_title("o2")).to eq([@video2])
    end

    it "returns empty array if no match title found" do
      expect(Video.search_by_title("vedio")).to be_empty
    end
  end

  describe "#recent_reviews" do
    it "returns an array of reviews ordered by updated time" do
      video = Fabricate(:video)
      Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)
      expect(video.recent_reviews(1)).to eq([review2])
    end
  end

  # describe "#rate" do
  #   it "returns average rate of its reviews" do
  #     video = Fabricate(:video)
  #     review1 = Fabricate(:review, rate: 1, video: video)
  #     review2 = Fabricate(:review, rate: 2, video: video)
  #     expect(video.rate).to eq('1.5')
  #   end
  # end

  describe "#reviews_count" do
    it "returns number of reviews" do
      video = Fabricate(:video)
      Fabricate(:review, rate: 1, video: video)
      Fabricate(:review, rate: 2, video: video)
      expect(video.reviews_count).to eq(2)
    end
  end

  describe "#in_user_queue?(user)" do
    it "returns true if the video is already in user's queue" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(video.in_user_queue?(user)).to be_truthy
    end
    it "returns false if the video is not in user's queue" do
      video = Fabricate(:video)
      user1 = Fabricate(:user)
      user2 = Fabricate(:user)
      queue_item = Fabricate(:queue_item, video: video, user: user1)
      expect(video.in_user_queue?(user2)).to be_falsey
    end
  end

end
