class Invitation < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :email, :name
  validates_uniqueness_of :email, scope: :user_id, 
                                  message: "Have invited him/her already"

  before_create do
    self.token = SecureRandom.urlsafe_base64
  end

end