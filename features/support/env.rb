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

# If you set this to false, any error raised from within your app will bubble 
# up to your step definition and out to cucumber unless you catch it somewhere
# on the way. You can make Rails rescue errors and render error pages on a
# per-scenario basis by tagging a scenario or feature with the @allow-rescue tag.
#
# If you set this to true, Rails will rescue all errors and render error
# pages, more or less in the same way your application would behave in the
# default production environment. It's not recommended to do this for all
# of your scenarios, as this makes it hard to discover errors in your application.
##ActionController::Base.allow_rescue = false

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
    #if SAUCE
      config.application_framework = :external
    #else
    #  config.application_framework = :rails
    #end

    config.mode = :selenium
    config.open_error_files = false # Set to true if you want error pages to pop up in the browser
    config.application_address     = ENV["HOST_TO_TEST"] 
    config.application_port        = SAUCE ? 80 : 3000
    config.selenium_server_address = SAUCE ? "ondemand.saucelabs.com" : "localhost" 
    config.selenium_server_port    = SAUCE ? 80 : 4444
    config.selenium_browser_key    = SAUCE ? sauce_browser : "*#{ENV["BROWSER"] || "firefox"}"
  end
end
