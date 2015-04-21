require 'rails_helper'

describe VideosController do
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
end
