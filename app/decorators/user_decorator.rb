class UserDecorator < Draper::Decorator
  delegate_all

  def next_pay_date
    active_until.to_date.strftime("%m/%d/%Y")
  end
end
