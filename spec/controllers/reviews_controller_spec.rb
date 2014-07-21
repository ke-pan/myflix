require 'spec_helper'

describe ReviewsController do
  
  describe "#create" do
    context "without login" do
      it_behaves_like "require log in" do
        let(:action) do
          video = Fabricate(:video)
          review = Fabricate.attributes_for(:review)
          post :create, video_id: video, review: review
        end
      end
    end

    context "with login" do
      before { set_current_user }

      context "with valid attributes" do
        it "saves a new review to database" do
          expect {
            post :create,
            video_id: Fabricate(:video),
            review: Fabricate.attributes_for(:review)
          }.to change(Review, :count).by(1)
        end
        it "redirect to video path" do
          video = Fabricate(:video)
          review = Fabricate.attributes_for(:review)
          post :create, video_id: video, review: review
          expect(response).to redirect_to video_path(video)
        end
      end

      context "with invalid attributes" do
        it "doesn't save a new review to database" do
          expect {
            post :create,
            video_id: Fabricate(:video),
            review: Fabricate.attributes_for(:review, rate: 6)
          }.to change(Review, :count).by(0)
        end
        it "renders back" do
          video = Fabricate(:video)
          review = Fabricate.attributes_for(:review, rate: 6)
          post :create, video_id: video, review: review
          expect(response).to render_template 'videos/show'
        end
      end
    end
  end
end