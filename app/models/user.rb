class User < ActiveRecord::Base

  has_many :reviews
  has_many :queue_items, -> {order "position"}
  has_many :followships
  has_many :followees, through: :followships
  has_many :followerships, class_name: "Followship", foreign_key: "followee_id"
  has_many :followers, through: :followerships, source: :user

  validates_presence_of :name, :email
  validates_uniqueness_of :email

  has_secure_password validations: false
  validates :password, presence: true, on: :create
  validates :password, length: { minimum: 5, if: :validate_password? }

  include Gravtastic
  gravtastic
  
  def validate_password?
    password.present? 
  end 

  def normalize_queue_items_positions
    queue_items.each_with_index do |item, index|
      item.update_attribute(:position, (index + 1))
    end
  end

  def follows?(another_user)
    followees.include? another_user
  end

  def get_followship(another_user)
    followships.find_by(followee: another_user)
  end

  def generate_reset_password_token
    self.reset_password_token = SecureRandom.urlsafe_base64
  end

end