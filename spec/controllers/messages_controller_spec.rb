require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  describe 'GET new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template 'new'
    end
  end
end
