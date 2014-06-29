class UpcomingPerformancesController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :index]

  def new
    @upcoming_performance = UpcomingPerformance.new
  end

  def create
    @upcoming_performance = UpcomingPerformance.new(upcoming_performance_params)
 
    if @upcoming_performance.save
      redirect_to @upcoming_performance
    else
      render 'new'
    end
  end

  private
  def upcoming_performance_params
    params.require(:upcoming_performance).permit(:date, :location,
                                                 :description, :title)
  end

  public
  def index
    @upcoming_performances = UpcomingPerformance.all
  end

  def show
    @upcoming_performance = UpcomingPerformance.find(params[:id])
  end

  def edit
    @upcoming_performance = UpcomingPerformance.find(params[:id])
  end

  def update
    @upcoming_performance = UpcomingPerformance.find(params[:id])

    if @upcoming_performance.update(upcoming_performance_params)
      redirect_to @upcoming_performance
    else
      render 'edit'
    end
  end

  def destroy
    @upcoming_performance = UpcomingPerformance.find(params[:id])
    @upcoming_performance.destroy
    
    redirect_to upcoming_performances_path
  end
end
