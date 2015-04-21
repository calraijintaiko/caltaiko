require 'rails_helper'

describe VideosController do
  describe 'GET new' do
    it 'renders the new template' do
      signed_in_as_a_valid_user
      get :new
      expect(response).to render_template 'new'
    end
  end

  describe 'GET edit' do
    before :each do
      @id = rand(1..100)
      @vid = create(:video, title: 'Cal Raijin Taiko - Sazanami', id: @id)
      signed_in_as_a_valid_user
    end

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

  describe 'POST create' do
    context 'all required attributes are present and valid' do
      it 'adds a new video with the given parameters to the database' do
        signed_in_as_a_valid_user
        attributes = {
          'title' => 'Cute Cats',
          'link' => 'https://www.youtube.com/watch?v=p2H5YVfZVFw',
          'year' => 2012
        }
        post :create, video: attributes
        attributes.each do |key, value|
          expect(assigns(:video).attributes[key]).to eq value
        end
      end
    end

    context 'not all required attributes are present or valid' do
      before :each do
        signed_in_as_a_valid_user
        attributes = {
          'title' => 'Cute Cats',
          'year' => 2012
        }
        post :create, video: attributes
      end

      it 'renders the new template' do
        expect(response).to render_template 'new'
      end

      it 'does not save the workshift to the database' do
        expect(Video.first).to be_nil
      end
    end
  end

  describe 'DELETE destroy' do
    it 'removes a video from the database' do
      signed_in_as_a_valid_user
      create(:video, id: 1)
      delete :destroy, id: 1
      expect(Video.find_by_id(1)).to be_nil
    end
  end

  describe 'when user not logged in' do
    it 'GET new redirects to the login page' do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'GET edit redirects to the login page' do
      create(:video, id: 1)
      get :edit, id: 1
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'POST create redirects to the login page' do
      attributes = {
        'title' => 'Cute Cats',
        'link' => 'https://www.youtube.com/watch?v=p2H5YVfZVFw',
        'year' => 2012
      }
      post :create, video: attributes
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'DELETE destroy redirects to the login page' do
      create(:video, id: 1)
      delete :destroy, id: 1
      expect(Video.find_by_id(1)).to_not be_nil
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
