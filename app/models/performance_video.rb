class PerformanceVideo < ActiveRecord::Base
  belongs_to :performance
  validates :title, presence: true
  validates :link, presence: true
  validates :performance_slug, presence: true
end
