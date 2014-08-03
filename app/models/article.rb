class Article < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  validates :title, presence: true
  validates :date, presence: true
  validates :text, presence: true

  def year
    return self.date.strftime("%Y")
  end

  def slug_candidates
    [
     :title,
     [:title, year],
     [:title, :date]
    ]
  end

  def self.current
    return Article.where(current: true).order('date ASC')
  end
end
