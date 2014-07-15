require 'spec_helper'

describe QueueItemsController do
  
  describe "GET #index" do
    context "without login" do
      it "redirects to register path" do
        get :index
        expect(response).to redirect_to register_path
      end
    end

    context "within login" do
      before do
        @user = Fabricate(:user)
        session[:user_id] = @user.id
      end
      it "assigns @queue_items to all queue_items" do
        queue_item1 = Fabricate(:queue_item, user: @user)        
        queue_item2 = Fabricate(:queue_item, user: @user)
        get :index
        expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
      end
      it "renders :index template" do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe "DELETE #remove_queue_item" do
    context "without login" do
      it "redirects to register path" do
        queue_item = Fabricate(:queue_item)
        delete :remove_queue_item, id: queue_item
        expect(response).to redirect_to register_path
      end
    end

    context "within login" do
      before do
        @user = Fabricate(:user)
        session[:user_id] = @user.id
        @item1 = Fabricate(:queue_item, user: @user, position: 1)
        @item2 = Fabricate(:queue_item, user: @user, position: 2)
      end
      it "delete one queue_item from database" do
        expect {
          delete :remove_queue_item, id: @item1
        }.to change(QueueItem, :count).by(-1)
      end

      it "redirects to my_queue_path" do
        delete :remove_queue_item, id: @item1
        expect(response).to redirect_to my_queue_path
      end

      it "decrement position of remain items" do
        delete :remove_queue_item, id: @item1
        item2 = QueueItem.first
        expect(item2.position).to eq(1)
      end
    end
  end

end