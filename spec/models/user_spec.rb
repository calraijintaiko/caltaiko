require 'rails_helper'

describe User do
  it "has a valid factory" do
    expect(create(:user)).to be_valid
  end
  it "is invalid without unique username" do
    expect(build(:user, username: nil)).to_not be_valid
    create(:user, username: "caltaiko")
    expect(build(:user, username: "caltaiko")).to_not be_valid
  end
  it "is invalid without unique email" do
    expect(build(:user, email: nil)).to_not be_valid
    create(:user, email: "caltaiko@gmail.com")
    expect(build(:user, email: "caltaiko@gmail.com")).to_not be_valid
  end
end
