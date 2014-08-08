require "rails_helper"

describe Member do
  it "has a valid factory" do
    expect(create(:member)).to be_valid
  end

  it "is invalid without a name of at least 2 letters" do
    expect(build(:member, name: nil)).to_not be_valid
    expect(build(:member, name: "I")).to_not be_valid
    expect(build(:member, name: "PJ")).to be_valid
  end

  it "is invalid without a gen with integer value greater than 0" do
    expect(build(:member, gen: "hello")).to_not be_valid
    expect(build(:member, gen: nil)).to_not be_valid
    expect(build(:member, gen: 0)).to_not be_valid
    expect(build(:member, gen: 99)).to be_valid
  end

  it "is invalid without a major of at least 2 letters" do
    expect(build(:member, major: nil)).to_not be_valid
    expect(build(:member, major: "A")).to_not be_valid
    expect(build(:member, major: "CS")).to be_valid
  end

  it "is invalid without a bio" do
    expect(build(:member, bio: nil)).to_not be_valid
  end

  describe "getting all current members or alumni" do
    before :each do 
      @created_current = create_list(:member, 23, current: true)
      @created_alumni = create_list(:member, 14, current: false)
    end

    context "for current members" do
      it "returns all current members" do
        expect(Member.current_members).to match_array @created_current
      end
    end

    context "for alumni" do
      it "returns all alumni" do
        expect(Member.alumni).to match_array @created_alumni
      end
    end
  end

  describe "getting all members of a certain gen" do
    it "returns all members of that gen" do
      gen_1 = create_list(:member, 8, gen: 1)
      gen_10 = create_list(:member, 40, gen: 10)
      expect(Member.gen(1)).to match_array gen_1
      expect(Member.gen(10)).to match_array gen_10
    end
  end

end
