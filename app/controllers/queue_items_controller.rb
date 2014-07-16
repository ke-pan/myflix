class QueueItemsController < ApplicationController
  before_action :test_login

  def index
    @queue_items = current_user.queue_items
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    if current_user.queue_items.include? queue_item
      QueueItem.where(
        "position > ? AND user_id = ?", 
        queue_item.position, current_user.id).each do |item|
        item.decrement!(:position)
      end
      queue_item.destroy
    end
    redirect_to my_queue_path
  end
end