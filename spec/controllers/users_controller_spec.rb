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

    it "sends right parameter to UserRegister service" do
      register_instance = double("register result")
      register = double("register result")
      allow(register_instance).to receive(:register).and_return(register)
      allow(register).to receive(:successful?).and_return(true)
      allow(register).to receive(:user_id)
      allow(register).to receive(:message)
      UserRegister.should_receive(:new).with(
        {"name" => 'kitty', "email" => "kitty@t.com", "password" => 'secret'}, '1ni3', 'dfiye'
        ).and_return(register_instance)
      post :create,
        user: {email: "kitty@t.com", name: 'kitty', password: 'secret', other: 'dhie'},
        stripeToken: '1ni3',
        token: 'dfiye'
    end
    context "register successes" do
      it "redirects to home path" do
        register = double("register result")
        UserRegister.any_instance.stub(:register).and_return(register)
        allow(register).to receive(:successful?).and_return(true)
        allow(register).to receive(:user_id)
        allow(register).to receive(:message)
        post :create, user: Fabricate.attributes_for(:user), stripeToken: 1234
        expect(response).to redirect_to home_path
      end
    end

    context "register un-successes" do
      before do
        register = double("register result")
        UserRegister.any_instance.stub(:register).and_return(register)
        allow(register).to receive(:successful?).and_return(false)
        allow(register).to receive(:message).and_return("something wrong!")
        post :create, user: Fabricate.attributes_for(:user), stripeToken: 1234
      end
      it "redirects to register path" do
        expect(response).to redirect_to register_path
      end
      it "shows error message" do
        expect(flash[:danger]).to eq "something wrong!"
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
