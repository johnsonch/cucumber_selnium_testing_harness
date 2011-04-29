When /^Wait for the developer$/ do
   puts "Waiting on you kid.  Press enter to continue"
   $stdout.flush
   input = $stdin.gets
end

Then /^I should see not "([^"]*)"$/ do |text|
  @selenium.text?(text).should_not be_true
end

Then /^I should see "([^"]*)"$/ do |text|
  @selenium.text?(text).should be_true
end
