Given /^I am on the "([^\"]*)"$/ do |page_name|
  visit '/login'
end

When /^I fill in the following:$/ do |table|
  criteria = table.rows_hash.each do |field, value|
    fill_in field, :with => value
  end
end

When /^I press "([^\"]*)"$/ do |button_name|
  click_button(button_name)
end

Then /^I should see "([^\"]*)"$/ do |content|
  page.should have_content(content)
end
