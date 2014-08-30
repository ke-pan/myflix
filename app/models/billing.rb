class Billing < ActiveRecord::Base
  belongs_to :user
  scope :recent, ->{ order(pay_date: :desc).includes(:user).limit(10) }
end
