class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rate
      t.integer :user_id, :video_id
      t.string :description
      t.timestamps
    end
  end
end
