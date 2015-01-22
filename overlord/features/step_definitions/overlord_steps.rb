Given(/^I visit the site$/) do
  visit ("/")
end

When(/^I configure my bomb with(?:out)? codes$/) do
  click_button ("configure")
end


And(/^I set the activation code to "([^"]*)"$/) do |code|
  click_button('Set Activation Code')
  fill_in 'code_input_box', :with => code
  click_button('Submit')
end

And(/^I set the deactivation code to "([^"]*)"$/) do |code|
  click_button('Set Deactivation Code')
  fill_in 'code_input_box', :with => code
  click_button('Submit')
end


Then(/^the bomb is not armed$/) do
  page.has_css?('input.inactive')
end

Given(/^the bomb is armed$/) do
  pending
end

And(/^armed$/) do
  page.has_css?('input.active')
end

When(/^I enter the activation code$/) do
  fill_in 'code_input_box', :with => 1111
  click_button('Submit')
end




Then(/^the bomb should detonate$/) do
  pending
end

When(/^I enter the wrong code three times$/) do
  pending
end

Then(/^the bomb will detonate$/) do
  pending
end

