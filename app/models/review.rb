class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validates_presence_of :rate, :description
  validates_inclusion_of :rate, in: 1..5
end