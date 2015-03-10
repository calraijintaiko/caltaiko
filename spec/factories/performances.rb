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

require 'faker'

FactoryGirl.define do
  factory :performance do |f|
    f.title { Faker::Company.bs }
    f.date { Time.new(rand(2005..Time.new.year), rand(1..12), rand(1..31)) }
    f.location { "#{Faker::Address.street_address}, #{Faker::Address.city}" }
    f.description { Faker::Company.catch_phrase }
  end
end
