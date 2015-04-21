Given /^(\d+) current members exist$/ do |num|
  FactoryGirl.create_list(:member, num.to_i, current: true)
end

Then /^I should see the name of every current member$/ do
  Member.current_members.each do |member|
    expect(page).to have_content(member.name)
  end
end

Given /^a member named "(.+)" exists$/ do |name|
  FactoryGirl.create(:member, name: name)
end
