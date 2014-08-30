require 'spec_helper'

describe BillingsController do
  describe "GET #index" do
    it_should_behave_like "require log in" do
      let(:action) { get :index, user_id: 1 }
    end

    context "access other people's billings" do
      let (:alice) { Fabricate(:user) }
      let (:bob) { Fabricate(:user) }
      before { set_current_user(alice) }

      it "redirects to home path" do
        get :index, user_id: bob.id
        expect(response).to redirect_to home_path
      end
      it "shows some wrong message" do
        get :index, user_id: bob.id
        expect(flash[:danger]).to be_present
      end

      context "admin" do
        before { set_current_admin }
        it "renders index template" do
          get :index, user_id: bob.id
          expect(response).to render_template :index
        end
      end

    end

    context "access one's own billings" do
      let(:alice) { Fabricate(:user) }
      let(:bob) { Fabricate(:user) }
      let(:billing1) { Fabricate(:billing, user: alice) }
      let(:billing2) { Fabricate(:billing, user: bob) }
      before do
        set_current_user(alice)
        get :index, user_id: alice.id
      end
      it "renders index template" do
        expect(response).to render_template :index
      end
      it "assigns billings" do
        expect(assigns(:billings)).to match_array([billing1])
      end
    end
  end

end
