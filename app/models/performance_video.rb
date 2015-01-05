# Performance Videos
class PerformanceVideo < ActiveRecord::Base
  belongs_to :performance
  validates :title, presence: true
  validates :link, presence: true
end
