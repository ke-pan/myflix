class CreateQueues < ActiveRecord::Migration
  def change
    create_table :queues do |t|
      t.integer :video_id
      t.integer :order
      t.timestamps
    end
  end
end
