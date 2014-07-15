require "spec_helper"

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }

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
end