require 'faker'

FactoryGirl.define do
  factory :message do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    content { Faker::Lorem.paragraphs(2).join("\r\n\r\n") }
    performance_request { [true, nil].sample }

    trait :perf_request do
      performance_request true
    end

    trait :non_perf_request do
      performance_request nil
    end

    factory :performance_request, traits: [:perf_request]
    factory :general_message, traits: [:non_perf_request]
  end
end
