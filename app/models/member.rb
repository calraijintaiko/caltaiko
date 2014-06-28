class Member < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 2 }
  validates :bio, presence: true
end
