Given /^a video called "(.+)" exists$/ do |title|
  FactoryGirl.create(:video, title: title)
end
