require 'spec_helper'

describe Category do

  it {should validate_presence_of(:name)}
  it {should have_many(:videos)}

  describe "#recent_videos" do
    before do
      @videos_array = 11.times.map do |i|
        Video.create(
          name: "my video#{i}", 
          description: "incredible!", 
          cover_url: "some/url/of/cover#{i}", 
          video_url: "some/url/of/video#{i}" 
        )
      end
      @category1 = Category.create(name: "my category1")
      @videos_array.each { |video| @category1.videos << video }
    end

    it "should return recent 10 videos" do
      expect(@category1.recent_videos(10)).to eq(@videos_array[1,10].reverse)
    end
  end

end