class Performance < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  validates :date, presence: true
  validates :location, presence: true
  validates :description, presence: true
  validates :title, presence: true

  Paperclip.interpolates :slug do |attachment, style|
    attachment.instance.slug # or whatever you've named your User's login/username/etc. attribute
  end

  has_attached_file :banner, :styles => { display: "800x9999", thumb: "300x110#" },
  path: "/performances/:slug/:attachment/:style/:filename",
  url: "/performances/:slug/:attachment/:style/:filename",
  default_url: "/images/performances/:attachment/:style/missing.png"
  include DeletableAttachment
  validates_attachment_content_type :banner, content_type: /\Aimage\/.*\Z/

  def year
    return self.date.strftime("%Y")
  end

  def full_date
    return self.date.to_date
  end

  def slug_candidates
    [
     [:title, year],
     [:title, full_date],
    ]
  end

  def self.upcoming_performances
    return Performance.where("date >= ?", Time.new).order('date ASC')
  end

  def self.past_performances
    return Performance.where("date < ?", Time.new).order('date DESC')
  end
end
