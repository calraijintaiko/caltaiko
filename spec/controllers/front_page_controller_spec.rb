require 'rails_helper'

describe FrontPageController do
  describe "GET main" do
    before :each do
      @upcoming_perfs = create_list(:performance, rand(5..20),
                                    date: Time.new(Time.now.year + 1))
      @current_articles = create_list(:article, rand(5..20), current: true)
    end

    it "assigns @performances to all upcoming performances" do
      get :main
      expect(assigns(:performances)).to match_array @upcoming_perfs
    end

    it "assigns @articles to all current articles" do
      get :main
      expect(assigns(:articles)).to match_array @current_articles
    end

    it "renders the main template" do
      get :main
      expect(response).to render_template "main"
    end
  end
end
