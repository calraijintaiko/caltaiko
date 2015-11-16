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

    it 'assigns @active_year to the latest year of past performances' do
      get :index
      expect(assigns(:active_year)).to eql @years.max.to_i
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
    context 'GET upcoming' do
      let(:upcoming) { create_list(:upcoming_performance, rand(5..20)) }

      before :each do
        get :upcoming
      end

      it 'assigns @upcoming to all upcoming performances' do
        expect(assigns(:upcoming)).to match_array upcoming
      end

      it 'renders the upcoming template' do
        expect(response).to render_template 'upcoming'
      end
    end

    context 'GET past' do
      let(:years) { %w(2005 2006 2008 2012) }

      before :each do
        @past_by_year = {}
        years.each do |year|
          @past_by_year[year] = create_list(:performance, rand(5..20),
                                            date: Time.zone.local(year))
        end
        get :past
      end

      it 'assigns @past to all past performances' do
        expect(assigns(:past)).to match_array @past_by_year.values.flatten
      end

      it 'assigns @by_year to all past performances broken down by year' do
        expect(assigns(:by_year).keys).to match_array years
        years.each do |year|
          expect(assigns(:by_year)[year]).to match_array @past_by_year[year]
        end
      end

      it 'assigns @active_year to the latest year of past performances' do
        expect(assigns(:active_year)).to eql years.max.to_i
      end

      it 'renders the past template' do
        expect(response).to render_template 'past'
      end
    end
  end

  describe 'POST create' do
    context 'all required attributes are present and valid' do
      it 'adds a new video with the given parameters to the database' do
        signed_in_as_a_valid_user
        attributes = {
          'title' => 'Showcase',
          'location' => 'Berkeley Playhouse',
          'description' => 'Come watch our spring showcase!',
          'date' => Time.zone.local(2011, 6, 19)
        }
        post :create, performance: attributes
        attributes.each do |key, value|
          expect(assigns(:performance).attributes[key]).to eq value
        end
      end
    end

    context 'not all required attributes are present or valid' do
      before :each do
        signed_in_as_a_valid_user
        attributes = {
          'location' => 'Berkeley Playhouse',
          'description' => 'Come watch our spring showcase!',
          'date' => Time.zone.local(2011, 6, 19)
        }
        post :create, performance: attributes
      end

      it 'renders the new template' do
        expect(response).to render_template 'new'
      end

      it 'does not save the workshift to the database' do
        expect(Performance.first).to be_nil
      end
    end
  end

  describe 'DELETE destroy' do
    it 'removes an performance from the database' do
      signed_in_as_a_valid_user
      create(:performance, id: 1)
      delete :destroy, id: 1
      expect(Performance.find_by_id(1)).to be_nil
    end
  end

  describe 'when user not logged in' do
    it 'GET new redirects to the login page' do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'GET edit redirects to the login page' do
      get :edit, id: 1
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'POST create redirects to the login page' do
      attributes = {
        'title' => 'Cute Cats',
        'link' => 'https://www.youtube.com/watch?v=p2H5YVfZVFw',
        'year' => 2012
      }
      post :create, performance: attributes
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'DELETE destroy redirects to the login page' do
      create(:performance, id: 1)
      delete :destroy, id: 1
      expect(Performance.find_by_id(1)).to_not be_nil
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
