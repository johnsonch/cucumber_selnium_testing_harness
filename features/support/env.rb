ENV["RAILS_ENV"] ||= "test"
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')

require 'cucumber/formatter/unicode' # Remove this line if you don't want Cucumber Unicode support
require 'cucumber/rails/rspec'
require 'cucumber/rails/world'
require 'cucumber/web/tableish'
require "selenium/client"
require 'rspec/rails'
require 'webrat'
require 'webrat/core/matchers'

SAUCE = ENV["HUB"].match(/sauce/)

Before do |scenario|

  if SAUCE 
    sauce_browser = {
          "username" => ENV["SAUCE_USERNAME"],
          "access-key" => ENV["SAUCE_KEY"],
          "os" => ENV["OS"] || "Windows 2003",
          "browser" => ENV["BROWSER"] || "firefox",
          "browser-version" => ENV["VERSION"] || "3.", 
          "job-name" => "#{scenario.name} - test"
        }.to_json
  end

  Webrat.configure do |config|
    
    config.application_framework = :external

    config.mode = :selenium
    config.open_error_files = false # Set to true if you want error pages to pop up in the browser
    config.application_address     = ENV["HOST_TO_TEST"] 
    config.application_port        = ENV["APP_PORT"] || 80
    config.selenium_server_address = SAUCE ? "ondemand.saucelabs.com" : "localhost" 
    config.selenium_server_port    = SAUCE ? 80 : 4444
    config.selenium_browser_key    = SAUCE ? sauce_browser : "*#{ENV["BROWSER"] || "firefox"}"
  end
end


After do |scenario|
  selenium.close_current_browser_session if selenium
end
