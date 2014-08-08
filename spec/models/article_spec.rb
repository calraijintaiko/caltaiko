require 'rails_helper'

describe Article do
  it "has a valid factory" do
    expect(create(:article)).to be_valid
  end
  it "is invalid without a title" do
    expect(build(:article, title: nil)).to_not be_valid
  end
  it "is invalid without a date" do
    expect(build(:article, date: nil)).to_not be_valid
  end
  it "is invalid without text" do
    expect(build(:article, text: nil)).to_not be_valid
  end

  describe "getting all current articles" do
    it "returns all articles marked current" do
      created_current = create_list(:article, 14, current: true)
      expect(Article.current).to match_array created_current
    end
  end

  describe "generating a slug" do
    before :each do
      @go_us = create(:article, title: "cal raijin taiko the best")
      @go_us_again = create(:article, title: "Cal Raijin Taiko the Best",
                            date: Time.new(2014))
      @keep_going_us = create(:article, title: "Cal raIJIN taIKO THE best",
                              date: Time.new(2014, 3, 25))
    end

    context "no other article by same name exists" do
      it "uses title as slug" do
        expect(@go_us.slug).to eq("cal-raijin-taiko-the-best")
      end
    end

    context "article by same name already exists" do
      it "uses title-year as slug" do
        expect(@go_us_again.slug).to eq("cal-raijin-taiko-the-best-2014")
      end
    end

    context "article by same name and same year already exists" do
      it "uses title-year-month-day as slug" do
        expect(@keep_going_us.slug).to eq("cal-raijin-taiko-the-best-2014-03-25")
      end
    end
  end
end
