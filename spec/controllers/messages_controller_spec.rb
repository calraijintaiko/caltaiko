require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  describe 'GET new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template 'new'
    end
  end

  describe 'POST create' do
    let(:post_create) { post :create, params: { message: attributes } }

    context 'no name is provided' do
      let(:attributes) do
        {
          'name': nil,
          'email': 'test@example.com',
          'content': 'This is a test'
        }
      end

      it 'renders the new template' do
        post_create
        expect(response).to render_template 'new'
      end

      it 'displays an error to the user' do
        post_create
        expect(flash[:alert]).to be_present
      end

      it 'does not send an email' do
        expect { post_create }.to change { ActionMailer::Base.deliveries.count }.by(0)
      end
    end

    context 'no email is provided' do
      let(:attributes) do
        {
          'name': 'Bob',
          'email': nil,
          'content': 'This is a test'
        }
      end

      it 'renders the new template' do
        post_create
        expect(response).to render_template 'new'
      end

      it 'displays an error to the user' do
        post_create
        expect(flash[:alert]).to be_present
      end

      it 'does not send an email' do
        expect { post_create }.to change { ActionMailer::Base.deliveries.count }.by(0)
      end
    end

    context 'no content is provided' do
      let(:attributes) do
        {
          'name': 'Bob',
          'email': 'test@example.com',
          'content': nil
        }
      end

      it 'renders the new template' do
        post_create
        expect(response).to render_template 'new'
      end

      it 'displays an error to the user' do
        post_create
        expect(flash[:alert]).to be_present
      end

      it 'does not send an email' do
        expect { post_create }.to change { ActionMailer::Base.deliveries.count }.by(0)
      end
    end

    context 'email could not be delivered' do
      let(:attributes) do
        {
          'name': 'Bob',
          'email': 'test@example.com',
          'content': 'This is a test'
        }
      end

      before :each do
        # Stub out the deliver method to simulate failed delivery
        allow_any_instance_of(Mail::Message).to receive(:deliver).and_raise
        post_create
      end

      it 'renders the new template' do
        expect(response).to render_template 'new'
      end

      it 'displays an error to the user that includes our email address' do
        expect(flash[:alert]).to be_present
        expect(flash[:alert]).to include 'caltaiko@gmail.com'
      end
    end

    context 'all required fields are present' do
      let(:attributes) do
        {
          'name': 'Bob',
          'email': 'test@example.com',
          'content': 'This is a test'
        }
      end

      it 'sends an email' do
        expect { post_create }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it 'displays a confirmation to the user' do
        post_create
        expect(flash[:notice]).to be_present
      end

      it 'redirects back to the contact page' do
        post_create
        expect(response).to redirect_to(contact_path)
      end
    end
  end
end
