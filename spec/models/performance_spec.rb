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
      expect(perf.upcoming?).to be_truthy
    end

    it "returns false if performance date is in the past" do
      perf = build(:performance, date: Time.now - 1)
      expect(perf.upcoming?).to be_falsey
    end
  end

  describe "getting all upcoming or past performances" do
    before :each do
      @upcoming1 = create(:performance, date: Time.new(Time.now.year + 1))
      @upcoming2 = create(:performance, date: Time.new(Time.now.year + 1))
      @past1 = create(:performance, date: Time.now - 1)
      @past2 = create(:performance, date: Time.now - 1)
    end

    context "for upcoming performances" do
      it "returns all upcoming performances" do
        expect(Performance.upcoming_performances).to include(@upcoming1, @upcoming2)
        expect(Performance.upcoming_performances).to_not include(@past1, @past2)
      end
    end

    context "for past performances" do
      it "returns all past performances" do
        expect(Performance.past_performances).to include(@past1, @past2)
        expect(Performance.past_performances).to_not include(@upcoming1, @upcoming2)
      end
    end
  end

  describe "getting all videos of this performance" do
    it "returns all videos that belong to this performance" do
      perf = create(:performance, id: 6)
      vid1 = create(:performance_video, performance_id: 6)
      vid2 = create(:performance_video, performance_id: 6)
      expect(perf.performance_videos).to include(vid1, vid2)
      expect(perf.performance_videos.length).to eq(2)
    end
  end
end
