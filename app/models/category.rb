class Category < ActiveRecord::Base
  has_many :video_category_relations
  has_many :videos, through: :video_category_relations

  validates :name, presence: true

  def recent_videos(limit_num = 6)
    self.videos.order(created_at: :desc).limit(limit_num)
  end

end