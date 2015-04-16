require 'rails_helper'

describe PerformancesController do
  describe 'GET index' do
    before :each do
      @years = %w(2005 2008)
      future_year = Time.zone.now.year + 1
      @created_upcoming = create_list(:performance, rand(5..20),
                                      date: Time.zone.local(future_year))
      @created_past_year0 = create_list(:performance, rand(5..20),
                                        date: Time.zone.local(@years[0]))
      @created_past_year1 = create_list(:performance, rand(5..20),
                                        date: Time.zone.local(@years[1]))
      @created_past = @created_past_year0 + @created_past_year1
    end

    it 'assigns @upcoming to all upcoming performances' do
      get :index
      expect(assigns(:upcoming)).to match_array @created_upcoming
    end

    it 'assigns @past to all past performances' do
      get :index
      expect(assigns(:past)).to match_array @created_past
    end

    it 'assigns @by_year to all past performances broken down by year' do
      get :index
      expect(assigns(:by_year).keys).to match_array @years
      expect(assigns(:by_year)[@years[0]]).to match_array @created_past_year0
      expect(assigns(:by_year)[@years[1]]).to match_array @created_past_year1
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template 'index'
    end
  end

  describe 'getting a specific performance' do
    before :each do
      @id = rand(1..100)
      @itf = create(:performance, title: 'international taiko festival',
                                  date: Time.zone.local(2010), id: @id)
      signed_in_as_a_valid_user
    end

    context 'GET show' do
      it 'gets performance using slug' do
        get :show, id: 'international-taiko-festival-2010'
        expect(assigns(:performance)).to eq @itf
      end

      it 'gets performance using id' do
        get :show, id: @id
        expect(assigns(:performance)).to eq @itf
      end

      it 'renders the show template' do
        get :show, id: @id
        expect(assigns(:performance)).to eq @itf
      end
    end

    context 'GET edit' do
      it 'gets performance using slug' do
        get :edit, id: 'international-taiko-festival-2010'
        expect(assigns(:performance)).to eq @itf
      end

      it 'gets performance using id' do
        get :edit, id: @id
        expect(assigns(:performance)).to eq @itf
      end

      it 'renders the show template' do
        get :edit, id: @id
        expect(assigns(:performance)).to eq @itf
      end
    end
  end

  describe 'getting all upcoming or past performances' do
    before :each do
      @years = %w(2005 2008)
      future_year = Time.zone.now.year + 1
      @created_upcoming = create_list(:performance, rand(5..20),
                                      date: Time.zone.local(future_year))
      @created_past_year0 = create_list(:performance, rand(5..20),
                                        date: Time.zone.local(@years[0]))
      @created_past_year1 = create_list(:performance, rand(5..20),
                                        date: Time.zone.local(@years[1]))
      @created_past = @created_past_year0 + @created_past_year1
    end

    context 'GET upcoming' do
      it 'assigns @upcoming to all upcoming performances' do
        get :upcoming
        expect(assigns(:upcoming)).to match_array @created_upcoming
      end

      it 'renders the upcoming template' do
        get :upcoming
        expect(response).to render_template 'upcoming'
      end
    end

    context 'GET past' do
      it 'assigns @past to all past performances' do
        get :past
        expect(assigns(:past)).to match_array @created_past
      end

      it 'assigns @by_year to all past performances broken down by year' do
        get :index
        expect(assigns(:by_year).keys).to match_array @years
        expect(assigns(:by_year)[@years[0]]).to match_array @created_past_year0
        expect(assigns(:by_year)[@years[1]]).to match_array @created_past_year1
      end

      it 'renders the past template' do
        get :past
        expect(response).to render_template 'past'
      end
    end
  end
end
