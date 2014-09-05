=begin
This controller simply provides a route for static pages like "About Us" or "Contact Us"
=end
class PagesController < ApplicationController
  def about
  end

  def contact
  end

  def media
    @videos = Video.all.order('year DESC')
    @videos_by_year = Video.by_year(@videos)
    @performances = Performance.have_images.order('date DESC')
    @performances_by_year = Performance.by_year(@performances)
  end
end
