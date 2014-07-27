require 'spec_helper'

describe ResetPasswordController do

  describe "POST #send_reset_password_email" do
    context "with invalid email" do
      it "redirects to forget password path" do
        post :send_reset_password_email, email: 'nobody@test.com'
        expect(response).to redirect_to forget_password_path
      end
      it "shows error messages" do
        post :send_reset_password_email, email: 'nobody@test.com'
        expect(flash[:danger]).to eq "There is some problems about your email."
      end
    end

    context 'with valid email' do
      it "sends email to the email address" do
        Fabricate(:user, email: "alice@test.com")
        post :send_reset_password_email, email: 'alice@test.com'
        expect(last_email.to).to eq ['alice@test.com']
      end

      it 'generates new token' do
        alice = Fabricate(:user, email: "alice@test.com", 
          reset_password_token: 'fake token')
        post :send_reset_password_email, email: 'alice@test.com'
        expect(alice.reload.reset_password_token).not_to eq 'fake token'
      end
    end
  end

  describe "GET #new_password" do
    context "with valid token" do
      it "generates new token" do
        alice = Fabricate(:user, email: "alice@test.com", 
          reset_password_token: 'fake token')
        get :new_password, token: 'fake token'
        expect(alice.reload.reset_password_token).not_to eq 'fake token'
      end
      it "renders new_password template" do
        alice = Fabricate(:user, email: "alice@test.com", 
          reset_password_token: 'fake token')
        get :new_password, token: 'fake token'
        expect(response).to render_template :new_password
      end
    end
    context "with invalid token" do
      it "redirects to invalid token path" do
        get :new_password, token: 'fake token'
        expect(response).to redirect_to invalid_token_path
      end
    end
  end

  describe "POST #update_password" do
    context 'with invalid token' do
      it "redirects to home path" do
        get :update_password, token: 'fake token'
        expect(response).to redirect_to home_path
      end
      it "shows error messages" do
        get :update_password, token: 'fake token'
        expect(flash[:danger]).to eq "can't find the user in the system."
      end
    end

    context 'with invalid password' do
      it "render :new_password" do
        alice = Fabricate(:user, email: "alice@test.com", 
          reset_password_token: 'fake token', password: "secret")
        get :update_password, token: 'fake token', password: '123'
        expect(response).to render_template :new_password
      end
    end

    context 'with valid token and password' do
      let!(:alice) do
        Fabricate(:user, email: "alice@test.com", 
          reset_password_token: 'fake token', password: "secret")
      end
      before do
        get :update_password, token: 'fake token', password: '123456'
      end
      it "redirects to signin path" do
        expect(response).to redirect_to signin_path
      end
      it "shows success messages" do
        expect(flash[:success]).to eq "Your password has reset successfully!"
      end
      it "change user's password" do
        expect(alice.reload.authenticate('123456')).to be_truthy
      end
    end
  end

end