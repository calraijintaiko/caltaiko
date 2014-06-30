class Member < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 2 }
  validates :gen, presence: true, numericality: {only_integer: true, greater_than: 0 }
  validates :major, presence: true, length: {minimum: 2}
  validates :bio, presence: true
end
