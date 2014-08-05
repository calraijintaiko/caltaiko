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
      current1 = create(:article, current: true)
      current2 = create(:article, current: true)
      past = create(:article, current: false)
      expect(Article.current).to include(current1, current2)
      expect(Article.current).to_not include past
    end
  end
end
