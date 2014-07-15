class QueueItemsController < ApplicationController
  before_action :test_login

  def index
    @queue_items = current_user.queue_items
  end

  def remove_queue_item
    queue_item = QueueItem.find(params[:id])
    QueueItem.where(
      "position > ? AND user_id = ?", 
      queue_item.position, current_user.id).each do |item|
      item.decrement!(:position)
    end
    queue_item.destroy
    redirect_to my_queue_path
  end
end