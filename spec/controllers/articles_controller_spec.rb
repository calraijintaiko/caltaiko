require 'rails_helper'

describe ArticlesController do
  describe "GET index" do
    before :each do
      @created_articles = create_list(:article, rand(5..20))
    end

    it "assigns @articles to all articles" do
      get :index
      expect(assigns(:articles)).to match_array @created_articles
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template "index"
    end
  end

  describe "getting a specific article" do
    before :each do
      @id = rand(1..100)
      @article = create(:article, id: @id, title: "Announcing Fall 2014 Tryouts!")
      signed_in_as_a_valid_user
    end

    context "GET show" do
      it "gets article using slug" do
        get :show, id: "announcing-fall-2014-tryouts"
        expect(assigns(:article)).to eq @article
      end

      it "gets article using id" do
        get :show, id: @id
        expect(assigns(:article)).to eq @article
      end

      it "renders the show template" do
        get :show, id: @id
        expect(response).to render_template "show"
      end
    end

    context "GET edit" do
      it "gets article using slug" do
        get :edit, id: "announcing-fall-2014-tryouts"
        expect(assigns(:article)).to eq @article
      end

      it "gets article using id" do
        get :edit, id: @id
        expect(assigns(:article)).to eq @article
      end

      it "renders the edit template" do
        get :edit, id: @id
        expect(response).to render_template "edit"
      end
    end
  end
end
