require 'rails_helper'

describe Performance do
  it "has a valid factory" do
    expect(create(:performance)).to be_valid
  end
  it "is invalid without a title" do
    expect(build(:performance, title: nil)).to_not be_valid
  end
  it "is invalid without a date" do
    expect(build(:performance, date: nil)).to_not be_valid
  end
  it "has a location" do
    expect(build(:performance, location: nil)).to_not be_valid
  end
  it "has a description" do
    expect(build(:performance, description: nil)).to_not be_valid
  end

  describe "generating a slug" do
    before :each do
      @itf2005 = create(:performance, title: "InterNationaL TaIkO FeStival",
                        date: Time.new(2005))
      @itf2005_2 = create(:performance, title: "international taiko festival",
                          date: Time.new(2005, 6, 19))
    end

    context "no other performance by same name in same year" do
      it "uses title-year as slug" do
        expect(@itf2005.slug).to eq("international-taiko-festival-2005")
      end
    end

    context "a performance with same name in same year already exists" do
      it "uses title-year-month-day as slug" do
        expect(@itf2005_2.slug).to eq("international-taiko-festival-2005-06-19")
      end
    end
  end

  describe "checking if a performance is upcoming" do
    it "returns true if performance date is in the future" do
      perf = build(:performance, date: Time.new(Time.now.year + 1))
      expect(perf.upcoming?).to be true
    end

    it "returns false if performance date is in the past" do
      perf = build(:performance, date: Time.now - 1)
      expect(perf.upcoming?).to be false
    end
  end

  describe "getting all upcoming or past performances" do
    before :each do
      @created_upcoming = create_list(:performance, rand(5..20),
                                      date: Time.new(Time.now.year + 1))
      @created_past = create_list(:performance, rand(5..20), date: Time.now - 1)
    end

    context "for upcoming performances" do
      it "returns all upcoming performances" do
        expect(Performance.upcoming_performances).to match_array @created_upcoming
      end
    end

    context "for past performances" do
      it "returns all past performances" do
        expect(Performance.past_performances).to match_array @created_past
      end
    end
  end

  describe "getting all videos of this performance" do
    it "returns all videos that belong to this performance" do
      id = rand(1..100)
      perf = create(:performance, id: id)
      vids = create_list(:performance_video, rand(10..20), performance_id: id)
      expect(perf.performance_videos).to match_array vids
    end
  end
end
