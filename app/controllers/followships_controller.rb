class FollowshipsController < ApplicationController
  before_action :test_login

  def index
    @followships = current_user.followships
  end

  def create
    followee = User.find(params[:followee_id])
    followship = Followship.create(user: current_user, followee: followee) unless followee == current_user
    if followship.save
      flash[:success] = "You successfully follow #{followee.name}."
    else
      flash[:danger] = "You've already follow #{followee.name}."
    end
    redirect_to user_path(followee)
  end

  def destroy
    followship = Followship.find(params[:id])
    followship.destroy if followship.user == current_user
    redirect_to people_path
  end

end