class BillingDecorator < Draper::Decorator
  delegate_all

  def serice_duration
    payment_begin_date + " - " + payment_end_date
  end

  def payment_begin_date
    pay_date.to_date.strftime("%m/%d/%Y")
  end

  def payment_end_date
    active_until.to_date.strftime("%m/%d/%Y")
  end

  def payment
    amount.to_s(:currency)
  end
end
