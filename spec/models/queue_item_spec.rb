require "spec_helper"

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_uniqueness_of(:video_id).scoped_to(:user_id) }
  it { should validate_numericality_of(:position).only_integer }

  describe "#video_name" do
    it "gets associated video's name" do
      video = Fabricate(:video, name: "huluwa")
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.video_name).to eq("huluwa")
    end
  end

  describe "#rate" do
    it "gets associated video's review's rate by current user if it is rated" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, video: video, user: user, rate: 4)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.rate).to eq(4)
    end

    it "gets nil if current user doesn't review this video" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.rate).to be_nil
    end

  end

  describe "#category" do
    it "gets first associated video's category" do
      category1 = Fabricate(:category)
      category2 = Fabricate(:category)
      video = Fabricate(:video, categories: [category1, category2])
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category).to eq(category1)
    end
  end

  describe "#category_name" do
    it "gets name of first associated video's category" do
      category1 = Fabricate(:category)
      category2 = Fabricate(:category)
      video = Fabricate(:video, categories: [category1, category2])
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category_name).to eq(category1.name)
    end
  end

  describe "#rate=rate_value" do
    it "changes rate of associated video's review if user rate it before" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      review = Fabricate(:review, rate: 3, video: video, user: user)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      queue_item.rate = 4
      expect(queue_item.rate).to eq(4)
    end

    it "sets rate of associated video's review if user didn't rate it" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      queue_item.rate = 4
      expect(Review.count).to eq(1)
      expect(queue_item.rate).to eq(4)
    end


  end
end