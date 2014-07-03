class Video < ActiveRecord::Base
  has_many :video_category_relations
  has_many :categories, through: :video_category_relations

  validates_presence_of :name, :description, :cover_url, :video_url

  def self.search_by_title(title)
    Video.where("name LIKE ?", "%#{title}%")
  end
end