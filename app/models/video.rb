class Video < ActiveRecord::Base
  has_many :video_category_relations
  has_many :categories, through: :video_category_relations
end