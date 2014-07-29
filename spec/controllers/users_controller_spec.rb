require 'spec_helper'

describe UsersController do
  
  describe "Get #new" do
    it "assigns a new User to @user without token" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "assigns @user with specific name and email if request with valid token" do
      invitation = Fabricate(:invitation)
      get :new, token: invitation.token
      expect(assigns(:user).email).to eq invitation.email
      expect(assigns(:user).name).to eq invitation.name
    end

    it "assigns a new User to @user with invalid token" do
      get :new, token: "123456"
      expect(assigns(:user)).to be_a_new(User)
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

      context "welcome email sending" do
        it "sends an email to right person" do
          post :create, user: { email: "test@email.com", password: "secret", name: "Test" }
          expect(last_email.to).to eq(["test@email.com"])
        end
        it "has right content" do
          post :create, user: { email: "test@email.com", password: "secret", name: "Test James" }
          expect(last_email.body).to include("Test James")
        end
      end

      it "sets followships between inviter and invitee with valid token" do
        inviter = Fabricate(:user)
        invitation = Fabricate(:invitation, user: inviter)
        post :create, user: { email: "test@email.com", password: "secret", name: "Test James" },
                      token: invitation.token
        invitee = User.find_by_email("test@email.com")
        expect(inviter.follows?(invitee)).to be_truthy
        expect(invitee.follows?(inviter)).to be_truthy
      end
      it 'delete invitation with valid token' do
        inviter = Fabricate(:user)
        invitation = Fabricate(:invitation, user: inviter)
        post :create, user: { email: "test@email.com", password: "secret", name: "Test James" },
                      token: invitation.token
        expect(Invitation.count).to be_zero
      end
      it "doesn't set followships between inviter and invitee with invalid token" do
        post :create, user: { email: "test@email.com", password: "secret", name: "Test James" },
                      token: "123456"
        invitee = User.find_by_email("test@email.com")
        expect(Followship.count).to be_zero
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

      it "doesn't send the email with invalid inputs" do
        clear_email
        post :create, user: Fabricate.attributes_for(:user, name: nil)
        expect(ActionMailer::Base.deliveries).to be_empty
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