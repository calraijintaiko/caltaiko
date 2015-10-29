# == Schema Information
#
# Table name: articles
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  date               :datetime
#  text               :text
#  current            :boolean
#  created_at         :datetime
#  updated_at         :datetime
#  slug               :string(255)
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#
# All current articles will show up on the homepage.
# Articles can be accessed using either their id or a slug
# assigned to them when they are created.
class Article < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  validates :title, presence: true
  validates :date, presence: true
  validates :text, presence: true

  DATE_FORMAT = '%B %d, %Y'

  Paperclip.interpolates :slug do |attachment, _style|
    attachment.instance.slug
  end

  # rubocop:disable Metrics/LineLength
  has_attached_file :image, styles: { thumb: '700x500#', carousel: '1000x450#' },
                            path: '/articles/:slug/:attachment/:style/:filename',
                            url: '/articles/:slug/:attachment/:style/:filename',
                            default_url: '/images/articles/:attachment/:style/missing.png'
  # rubocop:enable Metrics/LineLength
  include DeletableAttachment
  validates_attachment_content_type :image, content_type: %r{\Aimage/.*\Z}

  # Returns the year of the articles date as a String
  def year
    return date.strftime('%Y') unless date.nil?
  end

  # Returns the date of the article in the format year-month-day
  def full_date
    return date.to_date unless date.nil?
  end

  # Generates a unique slug for a new article based on it's title.
  # If an article by the same name already exists, adds year to the end.
  # If an article already exists using that same slug,
  # adds month and day as well.
  def slug_candidates
    [
      :title,
      [:title, year],
      [:title, full_date]
    ]
  end

  # Returns a short snippet of the article text.
  # Generally returns first paragraph, but if first paragraph is too long,
  # will serve up only first 500 characters.
  def snippet
    snippet = text.split("\r\n\r\n")[0]
    snippet = snippet[0, 500] + ' **[. . .]**' if snippet.length > 550
    snippet
  end

  # Returns either the date of the article or the empty string if the
  # article has no associated date, formatted according to DATE_FORMAT.
  def safe_date
    date ? date.strftime(DATE_FORMAT) : ''
  end

  # Returns all current articles.
  def self.current
    Article.where(current: true).order('date DESC')
  end
end
