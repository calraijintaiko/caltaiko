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
end
