=begin rdoc
The instance variable +upcoming_performances+ is needed in order to render
the upcoming performances feed on the home page.
=end
class FrontPageController < ApplicationController
  def main
    @performances = Performance.upcoming_performances
  end
end
