=begin rdoc
Articles have a title, date, and text. They also have a boolean flag
to mark them as current or not.
All current articles will show up on the homepage.

Articles can be accessed using either their id or a slug
assigned to them when they are created.
=end
class Article < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  validates :title, presence: true
  validates :date, presence: true
  validates :text, presence: true

  Paperclip.interpolates :slug do |attachment, style|
    attachment.instance.slug
  end

  has_attached_file :image, :styles => { thumb: "700x500#", full: "1000x300#" },
  path: "/articles/:slug/:attachment/:style/:filename",
  url: "/articles/:slug/:attachment/:style/:filename",
  default_url: "/images/articles/:attachment/:style/missing.png"
  include DeletableAttachment
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  # Returns the year of the articles date as a String
  def year
    if !(self.date.nil?)
      return self.date.strftime("%Y")
    end
  end

  # Returns the date of the article in the format year-month-day
  def full_date
    if !(self.date.nil?)
      return self.date.to_date
    end
  end

  # Generates a unique slug for a new article based on it's title.
  # If an article by the same name already exists, adds articles year to the end.
  # If an article already exists using that same slug,
  # adds month and day as well.
  def slug_candidates
    [
     :title,
     [:title, year],
     [:title, full_date]
    ]
  end

  # Returns all current articles.
  def self.current
    return Article.where(current: true).order('date DESC')
  end
end
