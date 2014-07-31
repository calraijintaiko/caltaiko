class PerformanceVideosController < ApplicationController
  before_action :authenticate_user!, :except => [:show]
  before_action :set_performance_video, only: [:show, :edit, :update, :destroy]

  def index
    @performance_videos = PerformanceVideo.all
  end

  def show
  end

  def new
    @performance_video = PerformanceVideo.new
    @performance = Performance.friendly.find(params[:performance])
  end

  def edit
  end

  def create
    @performance_video = PerformanceVideo.new(performance_video_params)

    if @performance_video.save
      redirect_to @performance_video
    else
      render 'new'
    end
  end

  def update
    respond_to do |format|
      if @performance_video.update(performance_video_params)
        format.html { redirect_to @performance_video, notice: 'Performance video was successfully updated.' }
        format.json { render :show, status: :ok, location: @performance_video }
      else
        render 'edit'
      end
    end
  end

  def destroy
    @performance_video.destroy
    respond_to do |format|
      format.html { redirect_to performance_videos_url, notice: 'Performance video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_performance_video
      @performance_video = PerformanceVideo.find(params[:id])
    end

    def performance_video_params
      params.require(:performance_video).permit(:title, :link, :performance_id)
    end
end
