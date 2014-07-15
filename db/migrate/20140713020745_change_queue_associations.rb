class ChangeQueueAssociations < ActiveRecord::Migration
  def change
    rename_column :queues, :video_id, :user_id
    remove_column :queues, :order
    add_column :videos, :queue_id, :integer
    add_column :videos, :order_in_queue, :integer
  end
end
