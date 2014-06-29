class VideoCategoryRelation < ActiveRecord::Base
  belongs_to :video
  belongs_to :category
end