# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home page$/ then root_path
    when /^the login page$/ then new_user_session_path
    when /^the performances page$/ then performances_path
    when /^the past performances page$/ then past_performances_path
    when /^the upcoming performances page$/ then upcoming_performances_path
    when /^the new member page$/ then new_member_path
    when /^the new article page$/ then new_article_path
    when /^the new performance page$/ then new_performance_path
    when /^the new video page$/ then new_video_path
    when /^the edit page for member "(.+)"$/ then
      @member = Member.find_by_name($1)
      edit_member_path(@member)
    when /^the edit page for article "(.+)"$/ then
      @article = Article.find_by_title($1)
      edit_article_path(@article)
    when /^the edit page for performance "(.+)"$/ then
      @performance = Performance.find_by_title($1)
      edit_performance_path(@performance)
    when /^the edit page for video "(.+)"$/ then
      @video = Video.find_by_title($1)
      edit_video_path(@video)

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
