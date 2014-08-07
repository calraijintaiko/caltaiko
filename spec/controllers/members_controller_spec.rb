require 'rails_helper'

describe MembersController do
  describe "GET index" do
    before :each do
      @created_current = create_list(:member, 5, current: true)
      @created_alumni = create_list(:member, 9, current: false)
    end

    it "assigns @current to all current members" do
      get :index
      @created_current.each do |current_member|
        expect(assigns(:current)).to include current_member
      end
    end

    it "assigns @alumni to all past members" do
      get :index
      @created_alumni.each do |alumni|
        expect(assigns(:alumni)).to include alumni
      end
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template "index"
    end
  end

  describe "getting a specific member" do
    before :each do
      @johnny = create(:member, name: "Johnny B", id: 34)
      signed_in_as_a_valid_user
    end

    context "GET show" do
      it "gets member using slug" do
        get :show, id: "johnny-b"
        expect(assigns(:member)).to eq @johnny
      end
      it "gets member using id" do
        get :show, id: 34
        expect(assigns(:member)).to eq @johnny
      end
      it "renders the show template" do
        get :show, id: 34
        expect(response).to render_template "show"
      end
    end

    context "GET edit" do
      it "gets member using slug" do
        get :edit, id: "johnny-b"
        expect(assigns(:member)).to eq @johnny
      end
      it "gets member using id" do
        get :edit, id: 34
        expect(assigns(:member)).to eq @johnny
      end
      it "renders the edit template" do
        get :edit, id: 34
        expect(response).to render_template "edit"
      end
    end
  end

  describe "getting all current members or alumni" do
    before :each do
      @created_current = create_list(:member, 5, current: true)
      @created_alumni = create_list(:member, 9, current: false)
    end

    context "GET current" do
      it "gets all current members" do
        get :current
        @created_current.each do |current_member|
          expect(assigns(:current)).to include current_member
        end
        expect(assigns(:current).length).to eq @created_current.length
      end

      it "renders the current template" do
        get :current
        expect(response).to render_template "current"
      end
    end

    context "GET alumni" do
      it "gets all alumni" do
        get :alumni
        @created_alumni.each do |alumnus|
          expect(assigns(:alumni)).to include alumnus
        end
        expect(assigns(:alumni).length).to eq @created_alumni.length
      end

      it "renders the alumni template" do
        get :alumni
        expect(response).to render_template "alumni"
      end
    end
  end

  describe "GET gen" do
    before :each do
      @gen1 = create_list(:member, 5, gen: 1)
      @gen8 = create_list(:member, 8, gen: 8)
    end

    it "returns all members of a certain gen" do
      get :gen, id: 1
      @gen1.each do |gen1_member|
        expect(assigns(:members)).to include gen1_member
      end
      expect(assigns(:members).length).to eq @gen1.length
      get :gen, id: 8
      @gen8.each do |gen8_member|
        expect(assigns(:members)).to include gen8_member
      end
      expect(assigns(:members).length).to eq @gen8.length
    end

    it "fails silently when given non-integer gen" do
      expect { get :gen, id: "yo mmama" }.to_not raise_error
      expect { get :gen, id: 2.1231 }.to_not raise_error
    end

    it "redirects to index when given gen other than integer greater than 0" do
      get :gen, id: "yo mama"
      expect(response).to redirect_to "/members"
      get :gen, id: -1
      expect(response).to redirect_to "/members"
    end
  end
end
