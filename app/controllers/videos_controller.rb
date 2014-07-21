class VideosController < ApplicationController

  before_action :test_login
  before_action :find_video, only: [:show, :add_to_queue]

  def index
    @categories = Category.all
  end

  def show
    @review = Review.new
  end

  def search
    @videos = Video.search_by_title params[:item]
  end

  def add_to_queue
    queue_item_order = current_user.queue_items.size + 1
    queue_item = QueueItem.create(user: current_user, video: @video, position: queue_item_order)
    flash[:danger] = "You can't add a video to queue twice" unless queue_item.valid?
    redirect_to my_queue_path
  end

  def find_video
    @video = Video.find(params[:id])
  end
end
