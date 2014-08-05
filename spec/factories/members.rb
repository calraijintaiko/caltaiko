require 'faker'

FactoryGirl.define do
  factory :member do |f|
    f.name  { Faker::Name.name }
    f.gen { Faker::Number.positive(1, 99) }
    f.major { Faker::Commerce.department }
    f.bio { Faker::Company.catch_phrase }
    f.current [true, false].sample
  end
end
