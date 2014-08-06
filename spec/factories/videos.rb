require 'faker'

FactoryGirl.define do
  factory :video do |f|
    f.title { Faker::Company.bs }
    f.link { Faker::Internet.url('www.youtube.com') }
    f.year { rand(2005..Time.new.year) }
  end
end
