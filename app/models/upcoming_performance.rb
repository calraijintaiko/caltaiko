class UpcomingPerformance < ActiveRecord::Base
  validates :date, presence: true
  validate :valid_future_time?
  validates :location, presence: true
  validates :description, presence: true
  validates :title, presence: true

  private
  def valid_future_time?
    if date.to_date < Time.new
      errors.add(:date, "must be in the future.")
    end
  end
end
