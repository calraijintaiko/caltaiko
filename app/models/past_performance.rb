class PastPerformance < ActiveRecord::Base
  validates :date, presence: true
  validate :valid_past_time?
  validates :location, presence: true
  validates :description, presence: true
  validates :title, presence: true

  private
  def valid_past_time?
    if date.to_date > Time.new
      errors.add(:date, "must be in the past.")
    end
  end
end
