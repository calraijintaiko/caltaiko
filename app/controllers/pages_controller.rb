# This controller controls pages not associated with a resource,
# such as the front page, "About Us", or "Contact Us" pages.
class PagesController < ApplicationController
  def front
    @performances = Performance.upcoming_performances
    @articles = Article.current
  end

  def about
    @page_title = 'ABOUT US'
  end

  def contact
    @page_title = 'CONTACT'
  end

  def media
    @page_title = 'MEDIA'
    @videos = Video.all.order('year DESC')
    @videos_by_year = Video.by_year(@videos)
    @videos_active_year = @videos.exists? ? @videos.maximum('year') : ''

    @performances = Performance.images?.order('date DESC')
    @performances_by_year = Performance.by_year(@performances)
    if @performances.exists?
      @galleries_active_year = @performances.maximum('date').year
    else
      @galleries_active_year = ''
    end
  end

  def media_videos
    @page_title = 'MEDIA'
    @videos = Video.all.order('year DESC')
    @videos_by_year = Video.by_year(@videos)
    @videos_active_year = @videos.exists? ? @videos.maximum('year') : ''
  end

  def media_galleries
    @page_title = 'MEDIA'
    @performances = Performance.images?.order('date DESC')
    @performances_by_year = Performance.by_year(@performances)
    if @performances.exists?
      @galleries_active_year = @performances.maximum('date').year
    else
      @galleries_active_year = ''
    end
  end
end
