class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

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

end