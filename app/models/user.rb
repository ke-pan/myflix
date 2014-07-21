class User < ActiveRecord::Base
  has_many :reviews
  has_many :queue_items, -> {order "position"}

  validates_presence_of :name, :email
  validates_uniqueness_of :email

  has_secure_password validations: false
  validates :password, presence: true, on: :create
  validates :password, length: { minimum: 5, if: :validate_password? }

  def validate_password?
    password.present? 
  end 

  def normalize_queue_items_positions
    queue_items.each_with_index do |item, index|
      item.update_attribute(:position, (index + 1))
    end
  end
end