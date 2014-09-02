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
    @videos_by_year = Hash.new
    @videos.each do |video|
      @videos_by_year[video.year.to_s] ||= []
      @videos_by_year[video.year.to_s] << video
    end
    @performances = Performance.have_images
  end
end
