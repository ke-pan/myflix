require 'spec_helper'

describe StripeWrapper::Charge do

  let(:token) do
    Stripe::Token.create(
      :card => {
        :number => card_token,
        :exp_month => 8,
        :exp_year => 2015,
        :cvc => "314"
      }
    ).id
  end

  context "with valid card" do
    let(:card_token) { 4242424242424242 }
    it "doesn't raise Stripe::CardError" do
      expect {
        StripeWrapper::Charge.charge(
          :token  => token,
          :amount => 999
        )
      }.not_to raise_error
    end
  end

  context "with invalid card" do
    let(:card_token) { 4000000000000020 }
    it "raises Stripe::CardError" do
      expect {
        StripeWrapper::Charge.charge(
          :token  => token,
          :amount => 999
        )
      }.to raise_error(Stripe::CardError)
    end
  end

end
