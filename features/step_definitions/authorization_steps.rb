Given /^I have an account with username "(.*?)" and password "(.*?)"(?: and email "(.*?)")$/ do |username, password, email|
  email ||= 'test@example.com'
  @user = User.create!(email: email, username: username, password: password,
                       password_confirmation: password)
end

When /^I try to log in with (?:email|username) "(.*?)" and password "(.*?)"$/ do |username, password|
  fill_in 'Login', with: username
  fill_in 'Password', with: password
  click_button 'Sign In'
end

Then /^I should be logged in$/ do
  expect(page).to have_content 'Logout'
end

Then /^I should not be logged in$/ do
  expect(page).to_not have_content 'Logout'
end
