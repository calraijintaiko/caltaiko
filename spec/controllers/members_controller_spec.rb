require 'rails_helper'

describe MembersController do
  describe "GET index" do
    before :each do
      @created_current = create_list(:member, rand(5..20), current: true)
      @created_alumni = create_list(:member, rand(5..20), current: false)
    end

    it "assigns @current to all current members" do
      get :index
      expect(assigns(:current)).to match_array @created_current
    end

    it "assigns @alumni to all past members" do
      get :index
      expect(assigns(:alumni)).to match_array @created_alumni
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template "index"
    end
  end

  describe "getting a specific member" do
    before :each do
      @id = rand(1..100)
      @johnny = create(:member, name: "Johnny B", id: @id)
      signed_in_as_a_valid_user
    end

    context "GET show" do
      it "gets member using slug" do
        get :show, id: "johnny-b"
        expect(assigns(:member)).to eq @johnny
      end
      it "gets member using id" do
        get :show, id: @id
        expect(assigns(:member)).to eq @johnny
      end
      it "renders the show template" do
        get :show, id: @id
        expect(response).to render_template "show"
      end
    end

    context "GET edit" do
      it "gets member using slug" do
        get :edit, id: "johnny-b"
        expect(assigns(:member)).to eq @johnny
      end
      it "gets member using id" do
        get :edit, id: @id
        expect(assigns(:member)).to eq @johnny
      end
      it "renders the edit template" do
        get :edit, id: @id
        expect(response).to render_template "edit"
      end
    end
  end

  describe "getting all current members or alumni" do
    before :each do
      @created_current = create_list(:member, rand(5..20), current: true)
      @created_alumni = create_list(:member, rand(5..20), current: false)
    end

    context "GET current" do
      it "gets all current members" do
        get :current
        expect(assigns(:current)).to match_array @created_current
      end

      it "renders the current template" do
        get :current
        expect(response).to render_template "current"
      end
    end

    context "GET alumni" do
      it "gets all alumni" do
        get :alumni
        expect(assigns(:alumni)).to match_array @created_alumni
      end

      it "renders the alumni template" do
        get :alumni
        expect(response).to render_template "alumni"
      end
    end
  end

  describe "GET gen" do
    before :each do
      @gens = [rand(1..5), rand(6..10)]
      @gen0 = create_list(:member, rand(5..20), gen: @gens[0])
      @gen1 = create_list(:member, rand(5..20), gen: @gens[1])
    end

    it "returns all members of a certain gen" do
      get :gen, id: @gens[0]
      expect(assigns(:members)).to match_array @gen0
      get :gen, id: @gens[1]
      expect(assigns(:members)).to match_array @gen1
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
