# == Schema Information
#
# Table name: articles
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  date               :datetime
#  text               :text
#  current            :boolean
#  created_at         :datetime
#  updated_at         :datetime
#  slug               :string(255)
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

require 'faker'

FactoryGirl.define do
  factory :article do |f|
    sequence(:title) { |n| "Article #{n}" }
    f.date { Faker::Business.credit_card_expiry_date }
    f.text { Faker::Company.catch_phrase }
  end
end
