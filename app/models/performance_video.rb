# Performance Videos
class PerformanceVideo < ActiveRecord::Base
  belongs_to :performance

  def embed_link
    link.sub('watch?v=', 'embed/')
  end
end
