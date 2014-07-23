require 'spec_helper'

describe FollowshipsController do
  describe 'GET #index' do
    context 'without log in' do
      it_should_behave_like "require log in" do
        let(:action) { get :index }
      end
    end

    context 'with log in' do
      it "assigns current user's followships" do
        alice = Fabricate(:user, name: "alice")
        bob = Fabricate(:user, name: "bob")
        charls = Fabricate(:user, name: "charls", followees: [alice, bob])
        set_current_user(charls)

        get :index
        expect(assigns(:followships)).to match_array(Followship.all)
      end
    end
  end

  describe "POST #create" do
    context 'without log in' do
      it_should_behave_like "require log in" do
        let(:action) { post :create }
      end
    end

    context 'with log in' do
      before do
        @alice = Fabricate(:user, name: "alice")
        @bob = Fabricate(:user, name: "bob")
        set_current_user(@alice)
      end
      it "redirects to user path if valid input" do
        post :create, user: @bob.id
        expect(response).to redirect_to user_path(@bob)
      end
      it "follows the user" do
        post :create, user: @bob.id
        expect(current_user.followees).to match_array([@bob])
      end
      it "doesn't follow a person twice" do
        followship = Fabricate(:followship, user: @alice, followee: @bob)
        post :create, user: @bob.id
        expect(Followship.count).to eq(1)
      end
    end
  end

  describe "delete #destroy" do
    context 'without log in' do
      it_should_behave_like "require log in" do
        let(:action) { delete :destroy, id: 1}
      end
    end

    context 'with log in' do
      before do
        @alice = Fabricate(:user, name: "alice")
        @bob = Fabricate(:user, name: "bob")
        @charls = Fabricate(:user, name: "charls")
        set_current_user(@charls)
      end

      it "redirects to people path" do
        followship1 = Fabricate(:followship, user: @charls, followee: @alice)
        delete :destroy, id: followship1.id
        expect(response).to redirect_to people_path
      end

      it "delete a followship of current_user" do
        followship1 = Fabricate(:followship, user: @charls, followee: @alice)
        followship2 = Fabricate(:followship, user: @charls, followee: @bob)
        delete :destroy, id: followship1
        expect(current_user.followships).to match_array([followship2])
      end

      it "doesn't delete other's followship" do
        followship1 = Fabricate(:followship, user: @bob, followee: @alice)
        followship2 = Fabricate(:followship, user: @charls, followee: @bob)
        delete :destroy, id: followship1
        expect(@bob.followships).to match_array([followship1])
      end
    end
  end
end