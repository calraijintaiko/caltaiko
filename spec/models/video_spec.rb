require 'rails_helper'

describe Video do
  it 'has a valid factory' do
    expect(create(:video)).to be_valid
  end

  it 'is invalid without a title' do
    expect(build(:video, title: nil)).to_not be_valid
  end

  it 'is invalid without a year between 2005 and present' do
    expect(build(:video, year: nil)).to_not be_valid
    expect(build(:video, year: 2004)).to_not be_valid
    expect(build(:video, year: Time.zone.now.year + 1)).to_not be_valid
  end

  it 'is invalid without a link that begins with http:// or https://' do
    expect(build(:video, link: nil)).to_not be_valid
    expect(build(:video, link: 'www.google.com')).to_not be_valid
    expect(build(:video, link: 'http://www.google.com')).to be_valid
    expect(build(:video, link: 'https://www.google.com')).to be_valid
  end

  it 'correctly grabs the YouTube ID from the URL' do
    video = create(:video, link: 'https://www.youtube.com/watch?v=OTWx8yql_5g')
    expect(video.youtube_id).to eq 'OTWx8yql_5g'
  end

  it 'returns all videos separated by year' do
    years = %w(2006 2008 2009 2010)
    videos_year0 = create_list(:video, rand(5..20), year: years[0])
    videos_year1 = create_list(:video, rand(5..20), year: years[1])
    videos_year2 = create_list(:video, rand(5..20), year: years[2])
    videos_year3 = create_list(:video, rand(5..20), year: years[3])
    all_videos = videos_year0 + videos_year1 + videos_year2 + videos_year3
    by_year = Video.by_year(all_videos)
    expect(by_year[years[0]]).to match_array videos_year0
    expect(by_year[years[1]]).to match_array videos_year1
    expect(by_year[years[2]]).to match_array videos_year2
    expect(by_year[years[3]]).to match_array videos_year3
  end

  describe 'generating a slug' do
    before :each do
      @video_0 = create(:video, title: 'Spring Showcase')
      @video_1 = create(:video, title: 'Spring Showcase', year: 2014)
    end

    context 'no other video by same title exists' do
      it 'uses title as slug' do
        expect(@video_0.slug).to eq 'spring-showcase'
      end
    end

    context 'video by sae title already exists' do
      it 'uses title-year as slug' do
        expect(@video_1.slug).to eq 'spring-showcase-2014'
      end
    end
  end
end
