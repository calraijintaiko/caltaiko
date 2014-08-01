module PerformancesHelper
  def setup_performance(performance)
    3.times { performance.performance_videos.build }
    return performance
  end
end
