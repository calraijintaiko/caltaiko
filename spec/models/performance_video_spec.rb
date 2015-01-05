require 'rails_helper'

describe PerformanceVideo do
  it 'has a valid factory' do
    expect(create(:performance_video)).to be_valid
  end
  it 'is invalid without a title' do
    expect(build(:performance_video, title: nil)).to_not be_valid
  end
  it 'has a link' do
    expect(build(:performance_video, link: nil)).to_not be_valid
  end
end
