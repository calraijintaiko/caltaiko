class Video < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  validates :link, presence: true
  validates :year, presence: true, numericality: {only_integer: true,
    greater_than: 2005, less_than_or_equal_to: Time.new.year }

  def slug_candidates
    [
     :title,
     [:title, :year],
    ]
  end

end
