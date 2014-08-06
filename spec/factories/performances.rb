require 'faker'

FactoryGirl.define do
  factory :performance do |f|
    f.title { Faker::Company.bs }
    f.date { Time.new(rand(2005..Time.new.year), rand(1..12), rand(1..31)) }
    f.location { "#{Faker::Address.street_address}, #{Faker::Address.city}" }
    f.description { Faker::Company.catch_phrase }
  end
end
