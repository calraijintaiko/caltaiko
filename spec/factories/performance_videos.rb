# == Schema Information
#
# Table name: performance_videos
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  link           :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  performance_id :integer
#

require 'faker'

FactoryGirl.define do
  factory :performance_video do |f|
    f.title { Faker::Company.bs }
    f.link { Faker::Internet.url('www.youtube.com') }
  end
end
