class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.text :description
      t.string :cover_url
      t.string :video_url
      t.timestamps
    end
  end
end
