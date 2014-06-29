class UpcomingPerformance < ActiveRecord::Base
  validates :date, presence: true
  validates :location, presence: true
  validates :description, presence: true
  validates :title, presence: true
end
