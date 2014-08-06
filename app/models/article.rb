class Article < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  validates :title, presence: true
  validates :date, presence: true
  validates :text, presence: true

  def year
    if !(self.date.nil?)
      return self.date.strftime("%Y")
    end
  end

def full_date
  if !(self.date.nil?)
    return self.date.to_date
  end
end

  def slug_candidates
    [
     :title,
     [:title, year],
     [:title, full_date]
    ]
  end

  def self.current
    return Article.where(current: true).order('date DESC')
  end
end
