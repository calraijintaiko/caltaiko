require 'rails_helper'

describe PagesController do
  describe 'GET front' do
    before :each do
      year = Time.zone.now.year + 1
      @upcoming_perfs = create_list(:performance, rand(5..20),
                                    date: Time.zone.local(year))
      @current_articles = create_list(:article, rand(5..20), current: true)
    end

    it 'assigns @performances to all upcoming performances' do
      get :front
      expect(assigns(:performances)).to match_array @upcoming_perfs
    end

    it 'assigns @articles to all current articles' do
      get :front
      expect(assigns(:articles)).to match_array @current_articles
    end

    it 'renders the front template' do
      get :front
      expect(response).to render_template 'front'
    end
  end

  describe 'GET about' do
    it 'renders the about template' do
      get :about
      expect(response).to render_template 'about'
    end
  end

  describe 'viewing photo galleries and videos' do
    let(:video_years) { %w(2005 2006 2009 2012) }
    let(:gallery_years) { %w(2008 2009 2010 2013) }

    before :each do
      @galleries_by_year = {}
      gallery_years.each do |year|
        @galleries_by_year[year] = create_list(:performance, rand(5..20),
                                               date: Time.zone.local(year),
                                               images_link: 'http://img.com')
      end

      @videos_by_year = {}
      video_years.each do |year|
        @videos_by_year[year] = create_list(:video, rand(5..20), year: year)
      end
    end

    context 'GET media' do
      before :each do
        get :media
      end

      it 'renders the media template' do
        expect(response).to render_template 'media'
      end

      it 'assigns @videos to all videos' do
        expect(assigns(:videos)).to match_array @videos_by_year.values.flatten
      end

      it 'assigns @videos_by_year to all videos, separated by year' do
        expect(assigns(:videos_by_year)).to match @videos_by_year
      end

      it 'assigns @performances to all performances' do
        performances = @galleries_by_year.values.flatten
        expect(assigns(:performances)).to match_array performances
      end

      it 'assigns @performances_by_year to all performances, by year' do
        expect(assigns(:performances_by_year)).to match @galleries_by_year
      end

      it 'assigns @galleries_active_year to the year of the latest gallery' do
        expect(assigns(:galleries_active_year)).to eql gallery_years.max.to_i
      end
    end

    context 'GET media_videos' do
      before :each do
        get :media_videos
      end

      it 'renders the media_videos template' do
        expect(response).to render_template 'media_videos'
      end

      it 'assigns @videos to all videos' do
        expect(assigns(:videos)).to match_array @videos_by_year.values.flatten
      end

      it 'assigns @videos_by_year to all videos, separated by year' do
        expect(assigns(:videos_by_year)).to match @videos_by_year
      end

      it 'assigns @videos_active_year to the year of the latest video' do
        expect(assigns(:videos_active_year)).to eql video_years.max.to_i
      end
    end

    context 'GET media_galleries' do
      before :each do
        get :media_galleries
      end

      it 'renders the media_galleries template' do
        expect(response).to render_template 'media_galleries'
      end

      it 'assigns @performances to all performances' do
        performances = @galleries_by_year.values.flatten
        expect(assigns(:performances)).to match_array performances
      end

      it 'assigns @performances_by_year to all performances, by year' do
        expect(assigns(:performances_by_year)).to match @galleries_by_year
      end

      it 'assigns @galleries_active_year to the year of the latest gallery' do
        expect(assigns(:galleries_active_year)).to eql gallery_years.max.to_i
      end
    end
  end
end
