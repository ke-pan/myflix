require 'spec_helper'

describe UserRegister do

  describe "#register" do

    context "with valid parameters and valid card info" do

      let(:user_register) { UserRegister.new({email: "test@email.com", password: "secret", name: "Test James"}, 1234, nil)}
      before { expect(StripeWrapper::Charge).to receive(:charge) }

      it "saves a new User to database" do
        expect {
          user_register.register
        }.to change(User, :count).by(1)
      end

      context "welcome email sending" do
        it "sends an email to right person" do
          user_register.register
          expect(last_email.to).to eq(["test@email.com"])
        end
        it "has right content" do
          user_register.register
          expect(last_email.body).to include("Test James")
        end
      end

      context "with invitation" do

        context 'with valid invitation token' do
          let(:inviter) { Fabricate(:user) }
          let(:invitation) { Fabricate(:invitation, user: inviter) }
          let(:user_register) { UserRegister.new({email: "test@email.com", password: "secret", name: "Test James"}, 1234, invitation.token)}

          before {user_register.register}
          it "sets followships between inviter and invitee with valid token" do
            invitee = User.find_by_email("test@email.com")
            expect(inviter.follows?(invitee)).to be_truthy
            expect(invitee.follows?(inviter)).to be_truthy
          end
          it 'delete invitation with valid token' do
            expect(Invitation.count).to be_zero
          end
        end

        context 'with invalid invitation token' do
          it "doesn't set followships between inviter and invitee with invalid token" do
            UserRegister.new(Fabricate.attributes_for(:user), 1234, 123456).register
            expect(Followship.count).to be_zero
          end
        end
      end
    end

    context "with invalid parameters" do
      let(:user_register) { UserRegister.new(Fabricate.attributes_for(:user, name: nil), 1234, nil)}
      it "doesn't save anything to database" do
        expect {
          user_register.register
        }.to_not change(User, :count)
      end

      it "doesn't send the email with invalid inputs" do
        clear_email
        user_register.register
        expect(ActionMailer::Base.deliveries).to be_empty
      end

      it "doesn't charge any payment" do
        user_register.register
        expect(StripeWrapper::Charge).not_to receive(:charge)
      end

    end

    context "with valid personal info and invalid card info" do
      let(:user_register) { UserRegister.new(Fabricate.attributes_for(:user), 1234, nil)}
      before do
        card_error = Stripe::CardError.new("Your card was declined.", nil, nil)
        StripeWrapper::Charge.should_receive(:charge).and_raise(card_error)
        @register = user_register.register
      end
      it "doesn't create any user" do
        expect(User.count).to eq 0
      end
      it "shows error flash" do
        expect(@register.message).to eq "Your card was declined."
      end
    end
  end
end
