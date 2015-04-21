# == Schema Information
#
# Table name: performances
#
#  id                  :integer          not null, primary key
#  date                :datetime
#  title               :string(255)
#  location            :string(255)
#  description         :text
#  created_at          :datetime
#  updated_at          :datetime
#  banner_file_name    :string(255)
#  banner_content_type :string(255)
#  banner_file_size    :integer
#  banner_updated_at   :datetime
#  slug                :string(255)
#  link                :string(255)
#  images_link         :string(255)
#

FactoryGirl.define do
  factory :performance do
    sequence(:title) { |n| "Performance #{n}" }
    sequence(:location) { |n| "Street #{n}, City #{n}" }
    sequence(:description) { |n| "Come watch Performance #{n}!" }
    images_link ''
    date do
      Time.zone.local(rand(2005..Time.zone.now.year),
                      rand(1..12), rand(1..31))
    end

    trait :upcoming do
      date { rand(1..100).days.from_now }
    end

    trait :past do
      date { rand(1..100).days.ago }
    end

    factory :upcoming_performance, traits: [:upcoming]
    factory :past_performance, traits: [:past]
  end
end
