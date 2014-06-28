class Member < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 5 }
  validates :bio, presence: true
end
