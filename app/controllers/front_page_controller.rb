class FrontPageController < ApplicationController
  def main
    @upcoming_performances = UpcomingPerformance.all
  end
end
