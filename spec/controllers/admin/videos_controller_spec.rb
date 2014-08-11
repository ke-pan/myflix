require 'spec_helper'

describe Admin::VideosController do
  describe 'GET new' do
    it_behaves_like "require log in" do
      let(:action) { get :new }
    end
    it_behaves_like 'require admin' do
      let(:action) { get :new }
    end
    it "assigns :video to a new Video" do
      set_current_admin
      get :new
      expect(assigns(:video)).to be_a_new(Video)
    end
  end

  describe 'POST create' do
    it_behaves_like "require log in" do
      let(:action) { post :create }
    end
    it_behaves_like 'require admin' do
      let(:action) { post :create }
    end
    it 'saves video to database when valid inputs' do
      set_current_admin
      expect {
         post :create, video: Fabricate.attributes_for(:video)
      }.to change(Video, :count).by(1)
    end
    it "doesn't save video when invalid inputs" do
      set_current_admin
      expect {
        post :create,
        video: { description: "something" }
      }.to change(Video, :count).by(0)
    end
  end

end
