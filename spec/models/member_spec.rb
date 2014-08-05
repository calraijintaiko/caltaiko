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

  describe "when getting either all current members or all alumni" do
    before :each do 
      @current1 = create(:member, current: true)
      @current2 = create(:member, current: true)
      @alumnus1 = create(:member, current: false)
      @alumnus2 = create(:member, current: false)
    end

    context "for current members" do
      it "returns all current members" do
        expect(Member.current_members).to_not include(@alumnus1, @alumnus2)
        expect(Member.current_members).to include(@current1, @current2)
      end
    end

    context "for alumni" do
      it "returns all alumni" do
        expect(Member.alumni).to include(@alumnus1, @alumnus2)
        expect(Member.alumni).to_not include(@current1, @current2)
      end
    end
  end

  it "returns all members of a certain gen" do
    tom = create(:member, gen: 1)
    andrew = create(:member, gen: 1)
    butt = create(:member, gen: 10)
    expect(Member.gen(1)).to include(tom, andrew)
    expect(Member.gen(1)).to_not include butt
  end

end
