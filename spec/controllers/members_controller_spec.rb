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
      expect(response).to render_template("members/index")
    end
  end
end
