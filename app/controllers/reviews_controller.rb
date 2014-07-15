class ReviewsController < ApplicationController

  before_action :test_login

  def create
    @review = Review.new(params.require(:review).permit([:rate, :description]))
    @video = Video.find(params[:video_id])
    @review.video = @video
    @review.user = current_user
    if @review.save
      flash[:success] = "Thank you for your review!"
      redirect_to video_path(@video)
    else
      render 'videos/show'
    end
  end
end