# == Schema Information
#
# Table name: videos
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  link       :string(255)
#  title      :string(255)
#  slug       :string(255)
#  year       :integer
#

require 'faker'

FactoryGirl.define do
  factory :video do |f|
    f.title { Faker::Company.bs }
    f.link { Faker::Internet.url('www.youtube.com') }
    f.year { rand(2005..Time.zone.now.year) }
  end
end
