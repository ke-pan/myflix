class Video < ActiveRecord::Base
  has_many :video_category_relations
  has_many :categories, through: :video_category_relations
  has_many :reviews
  has_many :queue_items

  validates_presence_of :name, :description, :cover_url, :video_url

  delegate :count, to: :reviews, prefix: "reviews"
  
  def self.search_by_title(title)
    Video.where("name LIKE ?", "%#{title}%")
  end

  def recent_reviews(limit_num = 10)
    self.reviews.order(:updated_at => :desc).limit(limit_num)
  end

  def rate
    return 0.0 if self.reviews.count == 0
    sum_rate = self.reviews.reduce(0.0) { |sum, review| sum + review.rate }
    "%.1f" % (sum_rate / self.reviews_count)
  end

  def in_user_queue?(user)
    queue_items.map(&:user_id).include?(user.id)
  end

end