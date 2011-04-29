Given /^I am on the TCCC website home page$/ do
  @selenium.start_new_browser_session
  @selenium.open "http://www.twincitiescodecamp.com"
end

When /^I click on "([^"]*)"$/ do |text|
  @selenium.click "link=#{text}", :wait_for => :page
end


