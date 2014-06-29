class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.timestamps
    end

    create_table :video_category_relations do |t|
      t.integer :video_id, :category_id
      t.timestamps
    end

  end
end
