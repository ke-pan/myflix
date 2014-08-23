require 'spec_helper'

describe VideoDecorator do
  describe "#rate" do
    it "returns average rate of its reviews" do
      video = Fabricate(:video)
      Fabricate(:review, rate: 1, video: video)
      Fabricate(:review, rate: 2, video: video)
      expect(video.decorate.rate).to eq('1.5')
    end
  end

end
