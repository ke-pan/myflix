class RenameQueueToPlayQueue < ActiveRecord::Migration
  def change
    rename_table :queues, :play_queues
    rename_column :videos, :queue_id, :play_queue_id
  end
end
