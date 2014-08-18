module StripeWrapper
  class Charge

    def self.charge(options)
      email = options[:email]
      customer = Stripe::Customer.create(
        :email => email,
        :card  => options[:token]
      )

      Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => options[:amount],
        :description => options[:description],
        :currency    => 'usd'
      )
    end
  end
end
