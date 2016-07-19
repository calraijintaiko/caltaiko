# Videos Controller
class VideosController < ApplicationController
  before_action :authenticate_user!

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)

    if @video.save
      flash[:notice] = "Successfully added \"#{@video.title}\" to media page"
      redirect_to media_videos_path
    else
      render 'new'
    end
  end

  def edit
    set_video
  end

  def update
    set_video

    if @video.update(video_params)
      flash[:notice] = "Successfully updated video \"#{@video.title}\""
      redirect_to media_videos_path
    else
      render 'edit'
    end
  end

  def destroy
    set_video
    @video.destroy

    flash[:notice] = "Successfully deleted video \"#{@video.title}\""
    redirect_to media_videos_path
  end

  private

  def set_video
    @video = Video.friendly.find(params[:id])
  end

  def video_params
    params.require(:video).permit(:title, :link, :year)
  end
end
