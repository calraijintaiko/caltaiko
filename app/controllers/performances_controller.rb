class PerformancesController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :index, :upcoming, :past]

  def index
    @upcoming = Performance.upcoming_performances
    @past = Performance.past_performances
  end

  def show
    set_performance
  end

  def new
    @performance = Performance.new
  end

  def edit
    set_performance
  end

  def create
    @performance = Performance.new(performance_params)

    if @performance.save
      redirect_to @performance
    else
      render 'new'
    end
  end

  def update
    set_performance

    if @performance.update(performance_params)
      redirect_to @performance
    else
      render 'edit'
    end
  end

  def destroy
    set_performance
    @performance.destroy

    redirect_to performances_path
  end

  def upcoming
    @upcoming = Performance.upcoming_performances
  end

  def past
    @past = Performance.past_performances
    @by_year = Hash.new false
    @past.each do |performance|
      if @by_year[performance.date.strftime("%Y")]
        @by_year[performance.date.strftime("%Y")] << performance
      else
        @by_year[performance.date.strftime("%Y")] = [performance]
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_performance
      @performance = Performance.friendly.find(params[:id])
    end

    def performance_params
      params.require(:performance).permit(:date, :title, :location, :link, :description,
                                          :upcoming, :banner, :delete_banner)
    end
end
