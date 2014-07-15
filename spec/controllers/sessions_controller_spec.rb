require "spec_helper"

describe SessionsController do
  describe "GET #new" do
    context "with logged in" do
      before do
        user = Fabricate(:user)
        session[:user_id] = user.id
      end
      it "redirects to home" do
        get :new
        expect(response).to redirect_to home_path
      end
    end
    context "without logged in" do
      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end
  end

  describe "POST #create" do
    context "with logged in" do
      before do
        user = Fabricate(:user)
        session[:user_id] = user.id
      end
      it "redirects to home" do
        post :create
        expect(response).to redirect_to home_path
      end
    end

    context "without logged in" do
      context "with valid attributes" do
        before do
          @user = Fabricate(
            :user, 
            email: "test@example.com", 
            password: "secret"
          )
          post :create, email: "test@example.com", password: "secret"
        end
        it "assigns session[:user_id] to user.id" do
          expect(session[:user_id]).to eq(@user.id)
        end
        it "redirects to home path" do
          expect(response).to redirect_to home_path
        end
      end
      context "with invalid attributes" do
        before do
          @user = Fabricate(
            :user, 
            email: "test@example.com", 
            password: "secret"
          )
          post :create, email: "wrong@example.com", password: "secret"
        end
        it "remains session[:user_id] to be nil" do
          expect(session[:user_id]).to be_nil
        end
        it "renders the :new template" do
          expect(response).to render_template :new
        end
      end
    end
  end

  describe "DELETE #destroy" do
    before do 
      user = Fabricate(:user)
      session[:user_id] = user.id
      delete :destroy
    end
    it "deletes session" do
      expect(session[:user]).to be_nil
    end
    it "redirects root" do
      expect(response).to redirect_to root_path
    end
  end
end