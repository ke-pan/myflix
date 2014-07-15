class ChangePlayQueue < ActiveRecord::Migration
  def change
    add_column :play_queues, :video_id, :integer
    add_column :play_queues, :order, :integer
    rename_table :play_queues, :queue_items
    remove_column :videos, :play_queue_id
    remove_column :videos, :order_in_queue
  end
end
