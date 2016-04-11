# == Schema Information
#
# Table name: performances
#
#  id                  :integer          not null, primary key
#  date                :datetime
#  title               :string(255)
#  location            :string(255)
#  description         :text
#  created_at          :datetime
#  updated_at          :datetime
#  banner_file_name    :string(255)
#  banner_content_type :string(255)
#  banner_file_size    :integer
#  banner_updated_at   :datetime
#  slug                :string(255)
#  link                :string(255)
#  images_link         :string(255)
class Performance < ActiveRecord::Base
  has_many :performance_videos, dependent: :destroy
  accepts_nested_attributes_for :performance_videos, allow_destroy: true,
                                                     reject_if: :reject_videos

  def reject_videos(attributed)
    attributed['title'].blank? || attributed['link'].blank? ||
      attributed['link'].match(%r{\Ahttps?:\/\/}).nil?
  end

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  validates :date, presence: true
  validates :location, presence: true
  validates :description, presence: true
  validates :title, presence: true
  validates :link, format: { with: %r{\Ahttps?:\/\/|\A\Z},
                             message: "URL must begin with 'http://'" }
  validates :images_link, format: { with: %r{\Ahttps?:\/\/|\A\Z},
                                    message: "URL must begin with 'http://'" }

  DATE_FORMAT = '%A, %B %d, %Y'
  TIME_FORMAT = '%l:%M %p'

  Paperclip.interpolates :slug do |attachment, _style|
    attachment.instance.slug
  end

  # rubocop:disable Style/AlignHash
  has_attached_file :banner, styles: { display: '1000x9999',
                                       thumb: '300x119#' },
    path: '/performances/:slug/:attachment/:style/:filename',
    url: '/performances/:slug/:attachment/:style/:filename',
    default_url: '/images/performances/:attachment/:style/missing.png',
    s3_protocol: :https
  # rubocop:enable Style/AlignHash
  include DeletableAttachment
  validates_attachment_content_type :banner, content_type: %r{\Aimage/.*\Z}

  # Returns the year of a specific performance.
  def year
    return date.strftime('%Y') unless date.nil?
  end

  # Returns the full date of a specific performance, in format YEAR MONTH DAY.
  def full_date
    date.to_date unless date.nil?
  end

  def display_date
    date.strftime(DATE_FORMAT) unless date.nil?
  end

  def display_time
    date.strftime(TIME_FORMAT) unless date.nil?
  end

  def display_datetime
    display_date + ', ' + display_time unless date.nil?
  end

  def google_maps_embed_url
    params = { key: Rails.application.secrets.google_maps_api_key,
               q: location }
    'https://www.google.com/maps/embed/v1/place?' + params.to_param
  end

  # Generates a unique slug for a performance.
  # Default slug is title and year; if performance with same name exists in same
  # year, uses title and full date. If performance with same name happened on
  # same day someone messed up, but it will use title, year, and unique ID.
  def slug_candidates
    [
      [:title, year],
      [:title, full_date]
    ]
  end

  # When called on a specific performance, returns true if performance
  # is upcoming, or false otherwise.
  def upcoming?
    date >= Time.zone.now
  end

  # Returns all upcoming performances in order of soonest to furthest away.
  def self.upcoming_performances
    Performance.where('date >= ?', Time.zone.now).order('date ASC')
  end

  # Returns all past performances in order of most recent to least.
  def self.past_performances
    Performance.where('date < ?', Time.zone.now).order('date DESC')
  end

  # Returns all performances that have an images link.
  def self.images?
    Performance.where.not("images_link = ''")
  end

  def self.by_year(performances)
    by_year = {}
    performances.each do |performance|
      by_year[performance.year] ||= []
      by_year[performance.year] << performance
    end
    by_year
  end
end
