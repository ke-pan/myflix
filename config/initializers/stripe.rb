Stripe.api_key = ENV['stripe_api_key']

class BillingEventLogger
  def initialize(logger)
    @logger = logger
  end

  def call(event)
    @logger.info "BILLING:#{event.type}:#{event.id}"
  end
end

class PaymentFailed
  def call(event)
    user = User.find_by(stripe_user_id: event.data.object.customer)
    user.update_attributes!(active: false)
  end
end

class PaymentSucceeded
  def call(event)
    user = User.find_by(stripe_user_id: event.data.object.customer)
    user.update_attributes!(
      active: true,
      active_until: Time.at(event.data.object.lines.data.period.end)
      )
    Billing.create!(
      pay_date: Time.at(event.data.object.lines.data.period.start),
      active_until: Time.at(event.data.object.lines.data.period.end),
      user: user,
      amount: 9.99
      )
  end
end

StripeEvent.configure do |events|
  events.all BillingEventLogger.new(Rails.logger)
  events.subscribe 'invoice.payment_succeeded', PaymentSucceeded.new
  events.subscribe 'charge.failed', PaymentFailed.new
end
