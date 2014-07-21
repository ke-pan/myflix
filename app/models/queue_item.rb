class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validates_uniqueness_of :video_id, scope: :user_id
  validates_numericality_of :position, only_integer: true

  delegate :name, to: :video, prefix: "video"

  def rate
    review = video.reviews.where(user: user).first
    review.rate if review
  end

  def category_name
    category.name
  end

  def category
    video.categories.first
  end

  def rate=(rate_value)
    review = video.reviews.where(user: user).first
    review ||= video.reviews.build(user: user)
    review.rate = rate_value
    review.description ||= "No Review"
    review.save
  end

end