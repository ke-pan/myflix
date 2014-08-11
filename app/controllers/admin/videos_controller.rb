class Admin::VideosController < AdministratorsController
  def new
    @video = Video.new
  end

  def create
    video = Video.new(video_params)
    if video.save
      flash[:success] = "You create a video successfully"
      redirect_to video_path(video)
    else
      flash[:danger] = "Sorry, something wrong when you create the video!"
      redirect_to new_admin_video_path
    end
  end

  private

  def video_params
    params.require(:video).permit(
      [:name, :description, :category_ids, :video_url, :small_cover, :large_cover]
    )
  end
end
