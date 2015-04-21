Given /^there are (\d+) upcoming performances$/ do |num|
  FactoryGirl.create_list(:upcoming_performance, num.to_i)
end

Then /^I should see every upcoming performance$/ do
  Performance.upcoming_performances.each do |performance|
    expect(page).to have_content(performance.title)
  end
end

When /^there are no upcoming performances$/ do
  Performance.upcoming_performances.destroy_all
end
