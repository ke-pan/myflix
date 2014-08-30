require 'spec_helper'

describe 'Stripe Webhooks' do
  describe 'invoice payment succeed' do
    let(:payment_succeeded_event) do
      {
        "id"=> "evt_14X2kLFuLUPU4NdLwZRrtDFl",
        "created"=> 1409370109,
        "livemode"=> false,
        "type"=> "invoice.payment_succeeded",
        "data"=> {
          "object"=> {
            "date"=> 1409370108,
            "id"=> "in_14X2kKFuLUPU4NdL7DIi6cQR",
            "period_start"=> 1409370108,
            "period_end"=> 1409370108,
            "lines"=> {
              "object"=> "list",
              "total_count"=> 1,
              "has_more"=> false,
              "url"=> "/v1/invoices/in_14X2kKFuLUPU4NdL7DIi6cQR/lines",
              "data"=> [
                {
                  "id"=> "sub_4gPZkmJUzKcBKX",
                  "object"=> "line_item",
                  "type"=> "subscription",
                  "livemode"=> false,
                  "amount"=> 999,
                  "currency"=> "usd",
                  "proration"=> false,
                  "period"=> {
                    "start"=> 1409370108,
                    "end"=> 1412048508
                  },
                  "quantity"=> 1,
                  "plan"=> {
                    "interval"=> "month",
                    "name"=> "Flix Monthly Subscription Payment",
                    "created"=> 1409054455,
                    "amount"=> 999,
                    "currency"=> "usd",
                    "id"=> "fmsp",
                    "object"=> "plan",
                    "livemode"=> false,
                    "interval_count"=> 1,
                    "trial_period_days"=> nil,
                    "metadata"=> {},
                    "statement_description"=> nil
                  },
                  "description"=> nil,
                  "metadata"=> {}
                }
              ]
            },
            "subtotal"=> 999,
            "total"=> 999,
            "customer"=> "cus_4gPZQB1bqQ8e30",
            "object"=> "invoice",
            "attempted"=> true,
            "closed"=> true,
            "forgiven"=> false,
            "paid"=> true,
            "livemode"=> false,
            "attempt_count"=> 1,
            "amount_due"=> 999,
            "currency"=> "usd",
            "starting_balance"=> 0,
            "ending_balance"=> 0,
            "next_payment_attempt"=> nil,
            "webhooks_delivered_at"=> nil,
            "charge"=> "ch_14X2kKFuLUPU4NdLp7Xq0GnK",
            "discount"=> nil,
            "application_fee"=> nil,
            "subscription"=> "sub_4gPZkmJUzKcBKX",
            "metadata"=> {},
            "statement_description"=> nil,
            "description"=> nil
          }
        },
        "object"=> "event",
        "pending_webhooks"=> 2,
        "request"=> "iar_4gPZ8BWW9tGfSa"
      }
    end
    it "create a billing", :vcr do
      Fabricate(:user, stripe_user_id: "cus_4gPZQB1bqQ8e30")
      post '/stripe-webhooks', payment_succeeded_event
      expect(Billing.count).to eq 1
    end
    it "create a billing associated to user", :vcr do
      alice = Fabricate(:user, stripe_user_id: "cus_4gPZQB1bqQ8e30")
      post '/stripe-webhooks', payment_succeeded_event
      expect(Billing.first.user).to eq alice
    end
  end

  describe "change failed" do
    let(:charge_failed_event) do
      {
        "id" => "evt_14XAAgFuLUPU4NdL1ryLzOI9",
        "created" => 1409398650,
        "livemode" => false,
        "type" => "charge.failed",
        "data" => {
          "object" => {
            "id" => "ch_14XAAgFuLUPU4NdLCIa9JKsY",
            "object" => "charge",
            "created" => 1409398650,
            "livemode" => false,
            "paid" => false,
            "amount" => 999,
            "currency" => "usd",
            "refunded" => false,
            "card" => {
              "id" => "card_14XA9wFuLUPU4NdLj3Ba8meO",
              "object" => "card",
              "last4" => "0341",
              "brand" => "Visa",
              "funding" => "credit",
              "exp_month" => 8,
              "exp_year" => 2018,
              "fingerprint" => "MKKTNSoabulB6TAB",
              "country" => "US",
              "name" => nil,
              "address_line1" => nil,
              "address_line2" => nil,
              "address_city" => nil,
              "address_state" => nil,
              "address_zip" => nil,
              "address_country" => nil,
              "cvc_check" => "pass",
              "address_line1_check" => nil,
              "address_zip_check" => nil,
              "customer" => "cus_4gRojw8pamJvLD"
            },
            "captured" => false,
            "refunds" => {
              "object" => "list",
              "total_count" => 0,
              "has_more" => false,
              "url" => "/v1/charges/ch_14XAAgFuLUPU4NdLCIa9JKsY/refunds",
              "data" => []
            },
            "balance_transaction" => nil,
            "failure_message" => "Your card was declined.",
            "failure_code" => "card_declined",
            "amount_refunded" => 0,
            "customer" => "cus_4gRojw8pamJvLD",
            "invoice" => nil,
            "description" => "",
            "dispute" => nil,
            "metadata" => {},
            "statement_description" => nil,
            "receipt_email" => nil
          }
        },
        "object" => "event",
        "pending_webhooks" => 2,
        "request" => "iar_4gXFfvmAFaMSEK"
      }
    end
    it "deactivate user", :vcr do
      alice = Fabricate(:user, active: true, stripe_user_id: "cus_4gRojw8pamJvLD")
      post '/stripe-webhooks', charge_failed_event
      expect(alice.reload).not_to be_active
    end
  end
end
