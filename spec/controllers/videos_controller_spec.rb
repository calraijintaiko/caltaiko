require 'rails_helper'

describe VideosController do
  describe 'GET index' do
    before :each do
      @years = %w(2010 2013)
      @created_videos_year0 = create_list(:video, rand(5..20), year: @years[0])
      @created_videos_year1 = create_list(:video, rand(5..20), year: @years[1])
      @created_videos = @created_videos_year0 + @created_videos_year1
    end

    it 'assigns @videos to all videos' do
      get :index
      expect(assigns(:videos)).to match_array @created_videos
    end

    it 'assigns @by_year to all videos broken down by year' do
      get :index
      expect(assigns(:by_year)[@years[0]]).to match_array @created_videos_year0
      expect(assigns(:by_year)[@years[1]]).to match_array @created_videos_year1
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template 'index'
    end
  end

  describe 'getting a specific video' do
    before :each do
      @id = rand(1..100)
      @vid = create(:video, title: 'Cal Raijin Taiko - Sazanami', id: @id)
    end

    context 'GET show' do
      it 'gets video using slug' do
        get :show, id: 'cal-raijin-taiko-sazanami'
        expect(assigns(:video)).to eq @vid
      end

      it 'gets video using id' do
        get :show, id: @id
        expect(assigns(:video)).to eq @vid
      end

      it 'renders the show template' do
        get :show, id: @id
        expect(response).to render_template 'show'
      end
    end

    context 'GET edit' do
      it 'gets video using slug' do
        get :edit, id: 'cal-raijin-taiko-sazanami'
        expect(assigns(:video)).to eq @vid
      end

      it 'gets video using id' do
        get :edit, id: @id
        expect(assigns(:video)).to eq @vid
      end

      it 'renders the edit template' do
        get :edit, id: @id
        expect(response).to render_template 'edit'
      end
    end
  end
end
