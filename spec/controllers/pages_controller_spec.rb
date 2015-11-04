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
    before :each do
      @years = [2010, 2011]
      @videos_year0 = create_list(:video, rand(5..20), year: @years[0])
      @videos_year1 = create_list(:video, rand(5..20), year: @years[1])
      @perf_year0 = create_list(:performance, rand(5..20),
                                date: Time.zone.local(@years[0]),
                                images_link: 'http://www.images.com')
      @perf_year1 = create_list(:performance, rand(5..20),
                                date: Time.zone.local(@years[1]),
                                images_link: 'http://www.images.com')
    end

    context 'GET media' do
      before :each do
        get :media
      end

      it 'renders the media template' do
        expect(response).to render_template 'media'
      end

      it 'assigns @videos to all videos' do
        expect(assigns(:videos)).to match_array(@videos_year0 + @videos_year1)
      end

      it 'assigns @videos_by_year to all videos, separated by year' do
        by_year = {
          @years[0].to_s => @videos_year0,
          @years[1].to_s => @videos_year1
        }
        expect(assigns(:videos_by_year)).to match by_year
      end

      it 'assigns @performances to all performances' do
        expect(assigns(:performances)).to match_array(@perf_year0 + @perf_year1)
      end

      it 'assigns @performances_by_year to all performances, by year' do
        by_year = {
          @years[0].to_s => @perf_year0,
          @years[1].to_s => @perf_year1
        }
        expect(assigns(:performances_by_year)).to match by_year
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
        expect(assigns(:videos)).to match_array(@videos_year0 + @videos_year1)
      end

      it 'assigns @videos_by_year to all videos, separated by year' do
        by_year = {
          @years[0].to_s => @videos_year0,
          @years[1].to_s => @videos_year1
        }
        expect(assigns(:videos_by_year)).to match by_year
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
        expect(assigns(:performances)).to match_array(@perf_year0 + @perf_year1)
      end

      it 'assigns @performances_by_year to all performances, by year' do
        by_year = {
          @years[0].to_s => @perf_year0,
          @years[1].to_s => @perf_year1
        }
        expect(assigns(:performances_by_year)).to match by_year
      end
    end
  end
end
