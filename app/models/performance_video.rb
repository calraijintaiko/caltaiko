# == Schema Information
#
# Table name: performance_videos
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  link           :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  performance_id :integer
class PerformanceVideo < ActiveRecord::Base
  belongs_to :performance

  validates :title, presence: true
  validates :link, format: { with: %r{\Ahttps?:\/\/},
                             message: "Url must begin with 'http://'" },
                   presence: true

  def youtube_id
    regex_match = /\watch\?v=(.+)\z/.match(link)
    return if regex_match.nil?
    regex_match[1]
  end
end
