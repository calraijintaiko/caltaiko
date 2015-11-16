# Controller for performances resource. Handles what information is sent
# to the views, as well as creation and updating of performances.
class PerformancesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index, :upcoming, :past]
  before_action :set_performance, only: [:show, :edit, :update, :destroy]
  before_action :merge_date_time, only: [:create, :update]

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
    @by_year = Performance.by_year(@past)
    @active_year = @past.exists? ? @past.maximum('date').year : ''
  end

  # Give performance whose ID or slug matches request.
  def show
    @performance_videos = @performance.performance_videos
  end

  # Give performance whose ID or slug matches request, to be used by form.
  def edit
  end

  # Find performance whose ID or slug matches request, then update parameters
  # to new inputted values. If updates successfully redirects to show
  # performance, otherwise back to edit form.
  def update
    if @performance.update(performance_params)
      redirect_to @performance
    else
      render 'edit'
    end
  end

  # Erase performance from database, then redirect to index page.
  def destroy
    @performance.delete_banner
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
    @by_year = Performance.by_year(@past)
    @active_year = @past.exists? ? @past.maximum('date').year : ''
  end

  private

  def set_performance
    @performance = Performance.friendly.find(params[:id])
  end

  def merge_date_time
    unless params[:performance][:date]
      date_string = params.delete(:date) + ' ' + params.delete(:time)
      date = DateTime.parse(date_string)

      params[:performance].merge!({
        'date(1i)' => date.year.to_s,
        'date(2i)' => date.month.to_s,
        'date(3i)' => date.day.to_s,
        'date(4i)' => date.hour.to_s,
        'date(5i)' => date.minute.to_s
      })
    end
  end

  # rubocop:disable Metrics/LineLength
  def performance_params
    params.require(:performance).permit(:date, :title, :location, :link,
                                        :description, :upcoming, :banner,
                                        :delete_banner, :images_link,
                                        performance_videos_attributes: [:title, :link, :id, :_destroy])
  end
  # rubocop:enable Metrics/LineLength
end
