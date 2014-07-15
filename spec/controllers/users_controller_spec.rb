require 'spec_helper'

describe UsersController do
  
  describe "Get #new" do
    before { get :new }

    it "assigns a new User to @user" do
      expect(assigns(:user)).to be_a_new(User)
    end
    it "renders the :new template" do
      expect(response).to render_template :new
    end
  end

  describe "Post #create" do

    context "with valid parameters" do
      it "saves a new User to database" do
        expect { 
          post :create, 
          user: Fabricate.attributes_for(:user) 
        }.to change(User, :count).by(1)
      end
      it "redirect to home path" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(response).to redirect_to home_path
      end
    end
    context "with invalid parameters" do
      it "doesn't save anything to database" do
        expect {
          post :create,
          user: Fabricate.attributes_for(:user, name: nil)
        }.to_not change(User, :count)
      end
      it "renders new template" do
        post :create, user: Fabricate.attributes_for(:user, name: nil)
        expect(response).to render_template :new
      end
    end
  end

end