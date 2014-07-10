class Performance < ActiveRecord::Base
  validates :date, presence: true
  validate :valid_future_time?
  validate :valid_past_time?
  validates :location, presence: true
  validates :description, presence: true
  validates :title, presence: true

  def self.upcoming_performances
    return Performance.where(upcoming: true).order('date ASC')
  end

  def self.past_performances
    return Performance.where(upcoming: false).order('date ASC')
  end

  private
  def valid_future_time?
    if date.to_date < Time.new && upcoming
      errors.add(:date, "must be in the future for upcoming performance.")
    end
  end
  def valid_past_time?
    if date.to_date > Time.new && !upcoming
      errors.add(:date, "must be in the past for past performance.")
    end
  end
end
