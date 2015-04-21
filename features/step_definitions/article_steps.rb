Given /^an article called "(.+)" exists$/ do |title|
  FactoryGirl.create(:article, title: title)
end
