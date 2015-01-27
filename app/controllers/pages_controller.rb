# This controller controls pages not associated with a resource,
# such as the front page, "About Us", or "Contact Us" pages.
class PagesController < ApplicationController
  def front
    @performances = Performance.upcoming_performances
    @articles = Article.current
  end

  def about
  end

  def contact
  end

  def media
    @videos = Video.all.order('year DESC')
    @videos_by_year = Video.by_year(@videos)
    @performances = Performance.images?.order('date DESC')
    @performances_by_year = Performance.by_year(@performances)
  end

  def showcase
    redirect_to 'http://caltaiko-showcase-2015.eventbrite.com'
  end

  def collegiate_taiko
  end
end
