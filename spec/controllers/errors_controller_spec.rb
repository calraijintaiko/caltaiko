require 'rails_helper'

describe ErrorsController do
  describe '404 Error - File Not Found' do
    it 'renders the 404 template' do
      get :file_not_found
      expect(response).to render_template 'file_not_found'
    end
  end

  describe '422 Error - Unprocessable Entity' do
    it 'renders the 422 template' do
      get :unprocessable
      expect(response).to render_template 'unprocessable'
    end
  end

  describe '500 Error - Internal Server Error' do
    it 'renders the 500 template' do
      get :internal_server_error
      expect(response).to render_template 'internal_server_error'
    end
  end
end
