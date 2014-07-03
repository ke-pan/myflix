require 'spec_helper'

describe Video do

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:cover_url) }
  it { should validate_presence_of(:video_url) }

  it { should have_many(:categories)}

  describe "#search_by_title" do
    before do
      @video1 = Video.create(
        name: "my video1", 
        description: "incredible!", 
        cover_url: "some/url/of/cover1", 
        video_url: "some/url/of/video1" 
        )
      @video2 = Video.create(
        name: "my video2", 
        description: "incredible!", 
        cover_url: "some/url/of/cover2", 
        video_url: "some/url/of/video2" 
        )
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



end