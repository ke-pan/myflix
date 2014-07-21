require 'spec_helper'

describe QueueItemsController do
  
  describe "GET #index" do
    context "without login" do
      it_behaves_like "require log in" do
        let(:action) { get :index }
      end
    end

    context "with login" do
      before { set_current_user }
      it "assigns @queue_items to all queue_items" do
        queue_item1 = Fabricate(:queue_item, user: current_user)        
        queue_item2 = Fabricate(:queue_item, user: current_user)
        get :index
        expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
      end
      it "renders :index template" do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe "DELETE #destroy" do
    context "without login" do
      it_behaves_like "require log in" do
        let(:action) do
          queue_item = Fabricate(:queue_item)
          delete :destroy, id: queue_item
        end
      end
    end

    context "with login" do
      before do
        set_current_user
        @item1 = Fabricate(:queue_item, user: current_user, position: 1)
        @item2 = Fabricate(:queue_item, user: current_user, position: 2)
      end
      it "deletes one queue_item from database" do
        expect {
          delete :destroy, id: @item1
        }.to change(QueueItem, :count).by(-1)
      end

      it "redirects to my_queue_path" do
        delete :destroy, id: @item1
        expect(response).to redirect_to my_queue_path
      end

      it "decrement position of remain items" do
        delete :destroy, id: @item1
        item2 = QueueItem.first
        expect(item2.position).to eq(1)
      end

      it "doesn't delete queue_item if it is not in current user's queue" do
        alice = Fabricate(:user)
        item3 = Fabricate(:queue_item, user: alice)
        delete :destroy, id: item3
        expect(QueueItem.count).to eq(3)
      end 
    end
  end

  describe "PUT #udpate" do
    context "without login" do
      it_behaves_like "require log in" do
        let(:action) do
          queue_item = Fabricate(:queue_item)
          put :update, queue_items: [{id: queue_item.id, position: 1}]
        end
      end
    end
    context "with login" do
      before do
        set_current_user
        @item1 = Fabricate(:queue_item, user: current_user, position: 1)
        @item2 = Fabricate(:queue_item, user: current_user, position: 2)
      end

      it "redirects to my_queue_path" do
        put :update, queue_items: [{id: @item1.id, position: 1}]
        expect(response).to redirect_to my_queue_path
      end

      it 're-orders the queue_items' do
        put :update, queue_items: [{id: @item2.id, position: 0}]
        expect(QueueItem.first.position).to eq(2)
        expect(QueueItem.last.position).to eq(1)
      end

      it 'remains the position of queue_items with invalid input' do
        put :update, queue_items: [{id: @item1.id, position: 3}, {id: @item2.id, position: 1.5}]
        expect(QueueItem.first.position).to eq(1)
        expect(QueueItem.last.position).to eq(2)
      end

      it "doesn't change other user's queue_item" do
        others = Fabricate(:user)
        others_item = Fabricate(:queue_item, user: others, position: 1)
        put :update, queue_items: [{id: others_item.id, position: 3}]
        expect(others.queue_items.first.position).to eq(1)
      end

      it "updates rate of queue_items" do
        video = Fabricate(:video)
        review = Fabricate(:review, video: video, user: current_user, rate: 5)
        queue_item = Fabricate(:queue_item, video: video, user: current_user, position: 3)
        put :update, queue_items: [{id: queue_item.id, position: 3, rate: 4}]
        expect(queue_item.reload.rate).to eq(4)
      end
    end
  end

end