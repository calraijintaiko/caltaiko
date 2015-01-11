# Performance Videos
class PerformanceVideo < ActiveRecord::Base
  belongs_to :performance
  validates :title, presence: true
  validates :link, presence: true

  def embed_link
    link.sub('watch?v=', 'embed/')
  end
end
