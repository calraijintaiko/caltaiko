class PastPerformancesController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :index]

  def new
    @past_performance = PastPerformance.new
  end

  def create
    @past_performance = PastPerformance.new(past_performance_params)
 
    if @past_performance.save
      redirect_to @past_performance
    else
      render 'new'
    end
  end

  private
  def past_performance_params
    params.require(:past_performance).permit(:date, :location,
                                             :description, :title)
  end

  public
  def index
    @past_performances = PastPerformance.all
  end

  def show
    @past_performance = PastPerformance.find(params[:id])
  end

  def edit
    @past_performance = PastPerformance.find(params[:id])
  end

  def update
    @past_performance = PastPerformance.find(params[:id])

    if @past_performance.update(past_performance_params)
      redirect_to @past_performance
    else
      render 'edit'
    end
  end

  def destroy
    @past_performance = PastPerformance.find(params[:id])
    @past_performance.destroy
    
    redirect_to past_performances_path
  end
end
