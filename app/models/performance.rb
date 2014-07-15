class Performance < ActiveRecord::Base
  validates :date, presence: true
  validate :valid_future_time?
  validate :valid_past_time?
  validates :location, presence: true
  validates :description, presence: true
  validates :title, presence: true

  has_attached_file :banner, :styles => { display: "800x9999" },
  path: "/performances/:id/:attachment/:style/:filename",
  url: "/performances/:id/:attachment/:style/:filename",
  default_url: "/images/performances/:attachment/:style/missing.png"
  include DeletableAttachment
  validates_attachment_content_type :banner, content_type: /\Aimage\/.*\Z/

  def self.upcoming_performances
    return Performance.where(upcoming: true).order('date ASC')
  end

  def self.past_performances
    return Performance.where(upcoming: false).order('date DESC')
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
