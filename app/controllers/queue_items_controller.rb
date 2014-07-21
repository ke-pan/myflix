class QueueItemsController < ApplicationController
  before_action :test_login

  def index
    @queue_items = current_user.queue_items
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    if current_user_has?(queue_item)
      queue_item.destroy
      current_user.normalize_queue_items_positions
    end
    redirect_to my_queue_path
  end

  def update
    # binding.pry
    begin
      update_attributes_by_params
      current_user.normalize_queue_items_positions
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = "Invalid position!"
    end
    redirect_to my_queue_path
  end

  private

  def update_attributes_by_params 
    QueueItem.transaction do
      params[:queue_items].each do |param|
        queue_item = QueueItem.find(param[:id])
        if current_user_has?(queue_item)
          queue_item.update_attributes!(:position => param[:position])
          queue_item.update_attributes!(:rate => param[:rate]) unless param[:rate].blank?
        end
      end
    end
  end

end