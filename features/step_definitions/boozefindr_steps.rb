Given /^I am at boozefindr\.com$/ do
  @selenium.start_new_browser_session
  @selenium.open "http://www.boozefindr.com"
end

Given /^I search for "([^"]*)" near "([^"]*)"$/ do |search_term, search_location|
  @selenium.type("drink_search_drink", search_term)
  @selenium.type("drink_search_location", search_location)
end

Then /^I should see the search results page$/ do
  @selenium.get_location.should eql("http://www.boozefindr.com/locations?drink_search%5Bdrink%5D=Revelstoke&drink_search%5Blocation%5D=Eau+Claire%2C+WI&commit=Booze+Me%21")
end

