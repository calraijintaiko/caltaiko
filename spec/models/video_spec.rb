require 'rails_helper'

describe Video do
  it "has a valid factory" do
    expect(create(:video)).to be_valid
  end
  it "is invalid without a title" do
    expect(build(:video, title: nil)).to_not be_valid
  end
  it "is invalid without a year between 2005 and present" do
    expect(build(:video, year: nil)).to_not be_valid
    expect(build(:video, year: 2004)).to_not be_valid
    expect(build(:video, year: Time.now.year + 1)).to_not be_valid
  end
  it "is invalid without a link" do
    expect(build(:video, link: nil)).to_not be_valid
  end
end
