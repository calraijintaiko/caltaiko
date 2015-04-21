Given /^a performance called "(.+)" exists$/ do |title|
  FactoryGirl.create(:performance, title: title)
end
