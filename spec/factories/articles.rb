require 'faker'

FactoryGirl.define do
  factory :article do |f|
    f.title { Faker::Company.bs }
    f.date { Faker::Business.credit_card_expiry_date }
    f.text { Faker::Company.catch_phrase }
  end
end
