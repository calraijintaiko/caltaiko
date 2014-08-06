require 'faker'

FactoryGirl.define do
  factory :performance_video do |f|
    f.title { Faker::Company.bs }
    f.link { Faker::Internet.url('www.youtube.com') }
  end
end
