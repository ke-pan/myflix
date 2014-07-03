class User < ActiveRecord::Base
  validates_presence_of :name, :email
  validates_uniqueness_of :email

  has_secure_password validations: false
  validates :password, presence: true, on: :create
  validates :password, length: { minimum: 5, if: :validate_password? }

  def validate_password?
    password.present? 
  end 

end