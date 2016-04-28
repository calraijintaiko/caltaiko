# Articles Helper
module ArticlesHelper
  # https://github.com/mpolakis/will_paginate/blob/c388e3ac0afc114ef2aa304c00737ad911f0146b/lib/will_paginate/view_helpers.rb#L122
  # From an unmerged part of the will_paginate gem
  # Generates links to be put in the <head> for SEO purposes.
  def pagination_link_tags(collection, params = {})
    output = []
    link = '<link rel="%s" href="%s" />'.freeze
    output << link % ['prev'.freeze,
      url_for(params.merge(page: collection.previous_page, only_path: false)
      )] if collection.previous_page
    output << link % ['next'.freeze,
      url_for(params.merge(page: collection.next_page, only_path: false))
      ] if collection.next_page
    output.join('\n'.freeze).html_safe
  end
end
