class Category < ActiveRecord::Base
  has_many :video_category_relations
  has_many :videos, through: :video_category_relations
end