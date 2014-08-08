require 'rails_helper'

describe PerformancesController do
  describe "GET index" do
    before :each do
      @years = ["2005", "2008"]
      @created_upcoming = create_list(:performance, 4, date: Time.new(Time.now.year + 1))
      @created_past_year0 = create_list(:performance, 5, date: Time.new(@years[0]))
      @created_past_year1 = create_list(:performance, 7, date: Time.new(@years[1]))
      @created_past = @created_past_year0 + @created_past_year1
    end

    it "assigns @upcoming to all upcoming performances" do
      get :index
      expect(assigns(:upcoming)).to match_array  @created_upcoming
    end

    it "assigns @past to all past performances" do
      get :index
      expect(assigns(:past)).to match_array @created_past
    end

    it "assigns @by_year to all past performances broken down by year" do
      get :index
      expect(assigns(:by_year).keys).to match_array @years
      expect(assigns(:by_year)[@years[0]]).to match_array @created_past_year0
      expect(assigns(:by_year)[@years[1]]).to match_array @created_past_year1
    end
  end
end
