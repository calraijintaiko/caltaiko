class PerformanceVideosController < ApplicationController
  before_action :authenticate_user!, :except => [:show]
  before_action :set_performance_video, only: [:show, :edit, :update, :destroy]

  def index
    @performance_videos = PerformanceVideo.all.order('performance_id ASC')
  end

  def show
  end

  def edit
  end

  def create
    @performance_video = PerformanceVideo.new(performance_video_params)

    respond_to do |format|
      if @performance_video.save
        format.html { redirect_to performance_videos_url, notice: 'Performance video was successfully created.' }
      else
        render 'new'
      end
    end
  end

  def update
    respond_to do |format|
      if @performance_video.update(performance_video_params)
        format.html { redirect_to performance_videos_url, notice: 'Performance video was successfully updated.' }
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
      params.require(:performance_video).permit(:title, :link)
    end
end
