=begin rdoc
Controller for performances resource. Handles what information is sent to the views,
as well as creation and updating of performances.
=end
class PerformancesController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :index, :upcoming, :past]
  before_action :set_performance, only: [:show, :edit, :update, :destroy]

  # Creates a blank performance to be used by form.
  def new
    @performance = Performance.new
  end


  # Push a new performance to the database with inputted parameters.
  # If saved successfully redirects to show performance, otherwise back to form.
  def create
    @performance = Performance.new(performance_params)

    if @performance.save
      redirect_to @performance
    else
      render 'new'
    end
  end

  # Default method for performances. Gives all upcoming and past performances.
  def index
    @upcoming = Performance.upcoming_performances
    @past = Performance.past_performances
    @by_year = Hash.new
    @past.each do |performance|
      @by_year[performance.date.strftime("%Y")] ||= []
      @by_year[performance.date.strftime("%Y")] << performance
    end
  end

  # Give performance whose ID or slug matches request.
  def show
    @performance_videos = @performance.performance_videos
  end

  # Give performance whose ID or slug matches request, to be used by form.
  def edit
  end

  # Find performance whose ID or slug matches request, then update parameters
  # to new inputted values. If updates successfully redirects to show performance,
  # otherwise back to edit form.
  def update
    if @performance.update(performance_params)
      redirect_to @performance
    else
      render 'edit'
    end
  end

  # Erase performance from database, then redirect to index page.
  def destroy
    @performance.destroy

    redirect_to performances_path
  end

  # Gives all upcoming performances, as received from Performance model.
  def upcoming
    @upcoming = Performance.upcoming_performances
  end

  # Gives all past performances, as received from Performance model.
  # Also gives a hash separating them by year.
  def past
    @past = Performance.past_performances
    @by_year = Hash.new
    @past.each do |performance|
      @by_year[performance.date.strftime("%Y")] ||= []
      @by_year[performance.date.strftime("%Y")] << performance
    end
  end

  private
    def set_performance
      @performance = Performance.friendly.find(params[:id])
    end

    def performance_params
      params.require(:performance).permit(:date, :title, :location, :link, :description,
                                          :upcoming, :banner, :delete_banner, :images_link,
                                          performance_videos_attributes: [:title, :link,
                                                                          :id, :_destroy])
    end
end
