# == Schema Information
#
# Table name: videos
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  link       :string(255)
#  title      :string(255)
#  slug       :string(255)
#  year       :integer
class Video < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  validates :title, presence: true
  # TODO: validate link for correct Youtube URL
  validates :link, format: { with: %r{\Ahttps?:\/\/},
                             message: "Url must begin with 'http://'" },
                   presence: true
  validates :year, presence: true,
                   numericality: { only_integer: true,
                                   greater_than_or_equal_to: 2005,
                                   less_than_or_equal_to: Time.zone.now.year }

  def slug_candidates
    [
      :title,
      [:title, :year]
    ]
  end

  def youtube_id
    regex_match = /\watch\?v=(.+)\z/.match(link)
    return if regex_match.nil?
    regex_match[1]
  end

  def self.by_year(videos)
    by_year = {}
    videos.each do |video|
      by_year[video.year.to_s] ||= []
      by_year[video.year.to_s] << video
    end
    by_year
  end
end
