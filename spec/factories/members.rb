# == Schema Information
#
# Table name: members
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  bio                 :text
#  created_at          :datetime
#  updated_at          :datetime
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  gen                 :integer
#  major               :string(255)
#  current             :boolean
#  slug                :string(255)
#  email               :string(255)
#

require 'faker'

FactoryGirl.define do
  factory :member do |f|
    sequence(:name) { |n| "Member #{n}" }
    f.gen { rand(1..20) }
    f.major { Faker::Commerce.department }
    f.bio { Faker::Company.catch_phrase }
    f.current { [true, false].sample }
  end
end
