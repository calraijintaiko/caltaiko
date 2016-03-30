require 'rails_helper'

describe PerformanceVideo do
  let (:performance) { create(:performance) }

  it 'is invalid without a title' do
    expect(build(:performance_video, title: '',
                 performance: performance)).to_not be_valid
  end

  it 'is invalid without a link that begins with http:// or https://' do
    expect(build(:performance_video, link: '',
                 performance: performance)).to_not be_valid
    expect(build(:performance_video, link: 'www.youtube.com/blahblah',
                 performance: performance)).to_not be_valid
    expect(build(:performance_video, link: 'http://www.youtube.com/blahblah',
                 performance: performance)).to be_valid
    expect(build(:performance_video, link: 'https://www.youtube.com/blahblah',
                 performance: performance)).to be_valid
  end

  it 'correctly grabs the YouTube ID from the URL' do
    video = create(:performance_video, performance: performance,
                   link: 'https://www.youtube.com/watch?v=OTWx8yql_5g')
    expect(video.youtube_id).to eq 'OTWx8yql_5g'
  end
end
