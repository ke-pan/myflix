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

  describe "GET #show" do
    context "without log in" do
      it_behaves_like "require log in" do
        let(:action) do 
          get :show, id: 1
        end
      end
    end

    context "with log in" do
      before do
        set_current_user
      end
      it "renders show template" do
        get :show, id: current_user
        expect(response).to render_template :show
      end
      it "assigns @user to the specific user" do
        alice = Fabricate(:user, name: "Alice")
        get :show, id: alice
        expect(assigns(:user)).to eq(alice)
      end
    end
  end

end