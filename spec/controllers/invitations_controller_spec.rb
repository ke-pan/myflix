require 'spec_helper'

describe InvitationsController do

  describe "GET #new" do
    context 'without log in' do
      it_should_behave_like "require log in" do
        let(:action) { get :new }
      end
    end

    context 'with log in' do
      it "assigns new invitation" do
        set_current_user
        get :new
        expect(assigns(:invitation)).to be_a_new Invitation
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
      before {set_current_user}
      after { clear_email }
      context 'with valid inputs' do
        before do
          post :create, 
            invitation: {name: "Hello Kitty", email: "hello-kitty@test.com",
                        message: "You should join the cool website!"}
        end
        it "create a invitation" do
          expect(Invitation.count).to eq(1)
        end
        it "sends email to the specific email" do
          expect(last_email.to).to eq ["hello-kitty@test.com"]
        end
        it "sends email that include the specific name" do
          expect(last_email.body).to include "Dear Hello Kitty"
        end
        it "sends email that include the specific message" do
          expect(last_email.body).to include "You should join the cool website!"
        end
        it 'redirects to confirm page' do
          expect(response).to redirect_to invitation_confirm_path
        end
      end
      context 'with invalid inputs' do
        it 'assigns invitation' do
          post :create, invitation: { name: "", email: "", message: "" }
          expect(assigns(:invitation)).to be_a_new Invitation
        end
        it 'render new template' do
          post :create, invitation: { name: "", email: "", message: "" }
          expect(response).to render_template :new
        end
      end

      it "doesn't invite people who's email is already in database" do
        hello_kitty = Fabricate(:user, email: "hello-kitty@test.com")
        post :create, 
            invitation: {name: "Hello Kitty", email: "hello-kitty@test.com",
                        message: "You should join the cool website!"}
        expect(Invitation.count).to eq(0)
      end
    end
  end
end