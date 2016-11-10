require 'rails_helper'

describe MembersController do
  describe 'GET new' do
    it 'renders the new template' do
      signed_in_as_a_valid_user
      get :new
      expect(response).to render_template 'new'
    end
  end

  describe 'GET index' do
    before :each do
      @created_current = create_list(:member, rand(5..20), current: true)
      @created_alumni = create_list(:member, rand(5..20), current: false)
    end

    it 'assigns @current to all current members' do
      get :index
      expect(assigns(:current)).to match_array @created_current
    end

    it 'assigns @alumni to all past members' do
      get :index
      expect(assigns(:alumni)).to match_array @created_alumni
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template 'index'
    end
  end

  describe 'for a specific member' do
    before :each do
      @id = rand(1..100)
      @johnny = create(:member, name: 'Johnny B', id: @id)
      signed_in_as_a_valid_user
    end

    context 'GET show' do
      it 'gets member using slug' do
        get :show, params: { id: 'johnny-b' }
        expect(assigns(:member)).to eq @johnny
      end
      it 'gets member using id' do
        get :show, params: { id: @id }
        expect(assigns(:member)).to eq @johnny
      end
      it 'renders the show template' do
        get :show, params: { id: @id }
        expect(response).to render_template 'show'
      end
    end

    context 'GET edit' do
      it 'gets member using slug' do
        get :edit, params: { id: 'johnny-b' }
        expect(assigns(:member)).to eq @johnny
      end
      it 'gets member using id' do
        get :edit, params: { id: @id }
        expect(assigns(:member)).to eq @johnny
      end
      it 'renders the edit template' do
        get :edit, params: { id: @id }
        expect(response).to render_template 'edit'
      end
    end

    context 'POST update' do
      context 'all required attributes are present and valid' do
        before :each do
          attributes = {
            name: 'Bob',
            gen: 20,
            major: 'Taiko yo',
            bio: 'new bio'
          }
          post :update, params: { member: attributes, id: @id }
        end

        it 'updates the members attributes to the submitted values' do
          johnny = Member.find(@id)
          expect(johnny.name).to eq 'Bob'
          expect(johnny.gen).to eq 20
          expect(johnny.major).to eq 'Taiko yo'
          expect(johnny.bio).to eq 'new bio'
        end

        it 'redirects to the members index template' do
          expect(response).to redirect_to members_path
        end

        it 'assigns @member to the updated member' do
          expect(assigns(:member).id).to eq @id
        end
      end

      context 'not all required attributes are present or valid' do
        before :each do
          attributes = {
            name: 'Bob',
            bio: nil
          }
          post :update, params: { member: attributes, id: @id }
        end

        it 'renders the edit template' do
          expect(response).to render_template 'edit'
        end

        it 'does not update the members attributes in the database' do
          johnny = Member.find(@id)
          expect(johnny.name).to eq 'Johnny B'
          expect(johnny.name).to_not eq 'Bob'
        end
      end
    end
  end

  describe 'GET database' do
    before :each do
      @created_current = create_list(:member, rand(5..20), current: true)
      @created_alumni = create_list(:member, rand(5..20), current: false)
      signed_in_as_a_valid_user
      get :database
    end

    it 'renders the database template' do
      expect(response).to render_template 'database'
    end

    it 'assigns @current to the current members' do
        expect(assigns(:current)).to match_array @created_current
    end

    it 'assigns @alumni to the alumni members' do
        expect(assigns(:alumni)).to match_array @created_alumni
    end
  end

  describe 'getting all current members or alumni' do
    before :each do
      @created_current = create_list(:member, rand(5..20), current: true)
      @created_alumni = create_list(:member, rand(5..20), current: false)
    end

    context 'GET current' do
      it 'assigns @current to all current members' do
        get :current
        expect(assigns(:current)).to match_array @created_current
      end

      it 'renders the current template' do
        get :current
        expect(response).to render_template 'current'
      end
    end

    context 'GET alumni' do
      it 'assigns @alumni to all alumni' do
        get :alumni

      end

      it 'renders the alumni template' do
        get :alumni
        expect(response).to render_template 'alumni'
      end
    end
  end

  describe 'GET gen' do
    before :each do
      @gens = [rand(1..5), rand(6..10)]
      @gen0 = create_list(:member, rand(5..20), gen: @gens[0])
      @gen1 = create_list(:member, rand(5..20), gen: @gens[1])
    end

    it 'returns all members of a certain gen' do
      get :gen, params: { gen: @gens[0] }
      expect(assigns(:members)).to match_array @gen0
      get :gen, params: { gen: @gens[1] }
      expect(assigns(:members)).to match_array @gen1
    end

    it 'fails when given non-integer gen' do
      expect { get :gen, params: { gen: 'yo mmama' }}.to raise_error ActionController::UrlGenerationError
      expect { get :gen, params: { gen: 2.1231 }}.to raise_error ActionController::UrlGenerationError
      expect { get :gen, params: { gen: -1 }}.to raise_error ActionController::UrlGenerationError
    end

    it 'redirects to index when given gen of 0' do
      get :gen, params: { gen: '0' }
      expect(response).to redirect_to members_path
    end
  end

  describe 'GET all_gens' do
    before :each do
      @gens = [rand(1..5), rand(6..10), rand(11..15)]
      @gen0 = create_list(:member, rand(5..20), gen: @gens[0])
      @gen1 = create_list(:member, rand(5..20), gen: @gens[1])
      @gen2 = create_list(:member, rand(5..20), gen: @gens[2])
      get :all_gens
    end

    it 'renders the all_gens template' do
      expect(response).to render_template 'all_gens'
    end

    it 'returns all the gens that members currently belong to' do
      assigns(:gens).each do |gen|
        expect(@gens).to include gen.gen
      end
    end
  end

  describe 'POST create' do
    context 'all required attributes are present and valid' do
      it 'adds a new video with the given parameters to the database' do
        signed_in_as_a_valid_user
        attributes = {
          'name' => 'Tom Hata',
          'major' => 'Taiko Drumming',
          'gen' => 1,
          'bio' => 'Tom Hata founder man',
          'current' => false
        }
        post :create, params: { member: attributes }
        attributes.each do |key, value|
          expect(assigns(:member).attributes[key]).to eq value
        end
      end
    end

    context 'not all required attributes are present or valid' do
      before :each do
        signed_in_as_a_valid_user
        attributes = {
          'major' => 'Taiko Drumming',
          'gen' => 1,
          'bio' => 'Tom Hata founder man',
          'current' => false
        }
        post :create, params: { member: attributes }
      end

      it 'renders the new template' do
        expect(response).to render_template 'new'
      end

      it 'does not save the workshift to the database' do
        expect(Member.first).to be_nil
      end
    end
  end

  describe 'DELETE destroy' do
    it 'removes an member from the database' do
      signed_in_as_a_valid_user
      create(:member, id: 1)
      delete :destroy, params: { id: 1 }
      expect(Member.find_by_id(1)).to be_nil
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

    it 'GET database redirects to the login page' do
      get :database
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'POST create redirects to the login page' do
      attributes = {
        'title' => 'Cute Cats',
        'link' => 'https://www.youtube.com/watch?v=p2H5YVfZVFw',
        'year' => 2012
      }
      post :create, params: { member: attributes }
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'DELETE destroy redirects to the login page' do
      create(:member, id: 1)
      delete :destroy, params: { id: 1 }
      expect(Member.find_by_id(1)).to_not be_nil
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
