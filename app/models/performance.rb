class Performance < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  validates :date, presence: true
  validates :location, presence: true
  validates :description, presence: true
  validates :title, presence: true

  has_attached_file :banner, :styles => { display: "800x9999" },
  path: "/performances/:id/:attachment/:style/:filename",
  url: "/performances/:id/:attachment/:style/:filename",
  default_url: "/images/performances/:attachment/:style/missing.png"
  include DeletableAttachment
  validates_attachment_content_type :banner, content_type: /\Aimage\/.*\Z/

  def slug_candidates
    [
     :title,
     #[:title, :year],
     #[:title, :full_date],
     [:title, :id]
    ]
  end

  def year
    return :date.strftime("%Y")
  end

  def full_date
    return :date.to_date.strftime("%m-%d-%Y")
  end

  def self.upcoming_performances
    return Performance.where("date >= ?", Time.new).order('date ASC')
  end

  def self.past_performances
    return Performance.where("date < ?", Time.new).order('date DESC')
  end
end
