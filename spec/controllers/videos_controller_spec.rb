require 'spec_helper'

describe VideosController do

  describe "GET #index" do
    context "without login" do
      it_behaves_like "require log in" do
        let(:action) { get :index }
      end
    end

    context "with login" do
      before { set_current_user }
      it "populates an array of all categories" do
        drama = Fabricate(:category, name: "drama")
        comedy = Fabricate(:category, name: "comedy")
        get :index
        expect(assigns(:categories)).to match_array([drama, comedy])
      end
      it "render :index view" do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe "GET #show" do

    context "without login" do
      it_behaves_like "require log in" do
        let(:action) do
          video = Fabricate(:video)
          get :show, id: video
        end
      end
    end

    context "with login" do
      before { set_current_user }

      it "assigns the requested video to @video" do
        video = Fabricate(:video)
        get :show, id: video
        expect(assigns(:video)).to eq(video)
      end
      it "renders show template" do
        video = Fabricate(:video)
        get :show, id: video
        expect(response).to render_template :show
      end
    end

  end

  describe "Get #search" do

    context "without login" do
      it_behaves_like "require log in" do
        let(:action) do
          video = Fabricate(:video)
          get :search, item: "h"
        end
      end
    end

    context "with login" do
      before { set_current_user }

      it "assigns the searched videos to @videos" do
        video = Fabricate(:video, name: "hello")
        get :search, item: "h"
        expect(assigns(:videos)).to match_array([video])
      end
      it "renders search template" do
        video = Fabricate(:video, name: "hello")
        get :search, item: "h"
        expect(response).to render_template :search
      end
    end
  end

  describe "POST #add_to_queue" do
    let(:video) { Fabricate(:video) }

    context "without login" do
      it_behaves_like "require log in" do
        let(:action) do
          post :add_to_queue, id: video
        end
      end
    end

    context "with login" do
      before { set_current_user }
      it "add a queue item to database" do
        expect {
          post :add_to_queue, id: video
        }.to change(QueueItem, :count).by(1)
      end
      it "redirect to my_queue path" do
        post :add_to_queue, id: video
        expect(response).to redirect_to my_queue_path
      end
      it "doesn't add a video to queues twice" do
        queue_item = Fabricate(:queue_item, user: current_user, video: video)
        expect {
          post :add_to_queue, id: video
        }.to change(QueueItem, :count).by(0)
      end
    end
  end

end