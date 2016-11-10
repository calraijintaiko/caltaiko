require 'rails_helper'

describe ArticlesController do
  describe 'GET new' do
    it 'renders the new template' do
      signed_in_as_a_valid_user
      get :new
      expect(response).to render_template 'new'
    end
  end

  describe 'GET index' do
    before :each do
      @created_articles = create_list(:article, rand(5..20))
    end

    it 'assigns @articles to all articles' do
      get :index
      expect(assigns(:articles)).to match_array @created_articles
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template 'index'
    end
  end

  describe 'getting a specific article' do
    before :each do
      @id = rand(1..100)
      @article = create(:article, id: @id,
                                  title: 'Announcing Fall 2014 Tryouts!')
      signed_in_as_a_valid_user
    end

    context 'GET show' do
      it 'gets article using slug' do
        get :show, params: { id: 'announcing-fall-2014-tryouts' }
        expect(assigns(:article)).to eq @article
      end

      it 'gets article using id' do
        get :show, params: { id: @id }
        expect(assigns(:article)).to eq @article
      end

      it 'renders the show template' do
        get :show, params: { id: @id }
        expect(response).to render_template 'show'
      end
    end

    context 'GET edit' do
      it 'gets article using slug' do
        get :edit, params: { id: 'announcing-fall-2014-tryouts' }
        expect(assigns(:article)).to eq @article
      end

      it 'gets article using id' do
        get :edit, params: { id: @id }
        expect(assigns(:article)).to eq @article
      end

      it 'renders the edit template' do
        get :edit, params: { id: @id }
        expect(response).to render_template 'edit'
      end
    end
  end

  describe 'POST create' do
    context 'all required attributes are present and valid' do
      it 'adds a new video with the given parameters to the database' do
        signed_in_as_a_valid_user
        attributes = {
          'title' => 'Cal Raijin Taiko is the bestest yo!',
          'date' => Time.zone.local(2012, 6, 19),
          'text' => 'Cal Raijin Taiko proved to be the bestest evar',
          'current' => true
        }
        post :create, params: { article: attributes }
        attributes.each do |key, value|
          expect(assigns(:article).attributes[key]).to eq value
        end
      end
    end

    context 'not all required attributes are present or valid' do
      before :each do
        signed_in_as_a_valid_user
        attributes = {
          'title' => 'Cal Raijin Taiko is the bestest yo!',
          'date' => Time.zone.now,
          'current' => true
        }
        post :create, params: { article: attributes }
      end

      it 'renders the new template' do
        expect(response).to render_template 'new'
      end

      it 'does not save the workshift to the database' do
        expect(Article.first).to be_nil
      end
    end
  end

  context 'POST update' do
    before :each do
      @id = 90
      create(:article, id: @id, title: 'An Awesome Article',
             date: Date.new(2016, 03, 30), text: 'Some cool article text')
      signed_in_as_a_valid_user
    end

    context 'all required attributes are present and valid' do
      before :each do
        attributes = {
          title: 'An Awesome New Title',
          date: Date.new(2016, 06, 19),
          text: 'Some new text'
        }
        post :update, params: { article: attributes, id: @id }
      end

      it 'updates the articles attributes to the submitted values' do
        article = Article.find(@id)
        expect(article.title).to eq 'An Awesome New Title'
        expect(article.date).to eq DateTime.new(2016, 06, 19, 0, 0, 0, '-07')
        expect(article.text).to eq 'Some new text'
      end

      it 'redirects to the show template for that article' do
        expect(response).to redirect_to Article.find(@id)
      end

      it 'assigns @article to the updated article' do
        expect(assigns(:article).id).to eq @id
      end
    end

    context 'not all required attributes are present or valid' do
      before :each do
        attributes = {
          title: 'An Awesome New Title',
          date: nil
        }
        post :update, params: { article: attributes, id: @id }
      end

      it 'renders the edit template' do
        expect(response).to render_template 'edit'
      end

      it 'does not update the articles attributes in the database' do
        article = Article.find(@id)
        expect(article.title).to eq 'An Awesome Article'
        expect(article.date).to eq DateTime.new(2016, 03, 30, 0, 0, 0, '-07')
      end
    end
  end

  describe 'DELETE destroy' do
    it 'removes an article from the database' do
      signed_in_as_a_valid_user
      create(:article, id: 1)
      delete :destroy, params: { id: 1 }
      expect(Article.find_by_id(1)).to be_nil
    end
  end

  describe 'when user not logged in' do
    it 'GET new redirects to the login page' do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'GET edit redirects to the login page' do
      get :edit, params: { id: 1 }
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'POST create redirects to the login page' do
      attributes = {
        'title' => 'Cute Cats',
        'link' => 'https://www.youtube.com/watch?v=p2H5YVfZVFw',
        'year' => 2012
      }
      post :create, params: { article: attributes }
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'DELETE destroy redirects to the login page' do
      create(:article, id: 1)
      delete :destroy, params: { id: 1 }
      expect(Article.find_by_id(1)).to_not be_nil
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
