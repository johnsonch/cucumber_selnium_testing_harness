Given /^I am on the Google Advanced Search site$/ do
  selenium.start_new_browser_session
  selenium.open "http://www.google.com/advanced_search"
end

Given /^I fill out all these words field with "([^"]*)"$/ do |search_terms|
  selenium.type("as_q", search_terms)
end

Given /^I add "([^"]*)" to a one or more of these words field$/ do |additional_terms|
  selenium.type("as_oq0", additional_terms)
end

Given /^I  add "([^"]*)" and "([^"]*)" to the any of these unwanted words field$/ do |term1, term2|
  selenium.type("as_eq", "#{term1} #{term2}")
end

When /^I click "([^"]*)"$/ do |button|
  selenium.click "//input[@value='#{button}']", :wait_for => :page
end

Then /^I should see "([^"]*)" in the search field$/ do |actual_search_term|
  selenium.value("q").should eql(actual_search_term)
end

