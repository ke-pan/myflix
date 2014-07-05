class VideosController < ApplicationController
  def index
    binding.pry
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
  end

  def search
    @videos = Video.search_by_title params[:item]
  end

end
