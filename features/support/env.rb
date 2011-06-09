require 'webrat'
require 'webrat/core/matchers'
require 'sauce'

SAUCE = ENV["HUB"].match(/sauce/)

Before do |scenario|
  browser = ENV["BROWSER"] || "firefox"
  browser_version = ENV["VERSION"] || "3."
  os = ENV["OS"] || "Windows 2003"
  host_to_test = ENV["HOST_TO_TEST"] || "http://www.google.com"
  app_port = ENV["APP_PORT"] == 80 ? "" : ":#{ENV["APP_PORT"]}"
  
  # Because Sauce Labs has their own gem that works better against the Sauce severs we want to use that
  # when we are running against Sauce. Otherwise the good ol' Selenium Client Driver will do
  if SAUCE
    @selenium = Sauce::Selenium.new(:browser_url => host_to_test + app_port, 
                                    :browser => browser, 
                                    :browser_version => browser_version, 
                                    :os => os,
                                    :job_name => scenario.name)
  else
      @selenium = Selenium::Client::Driver.new(
          :host => ENV["HUB"] || "localhost",
          :port => 4444,
          :browser => "*#{browser}",
          :url => host_to_test,
          :timeout_in_second => 60)
  end
  @selenium.start_new_browser_session
end

After do |scenario|
  @selenium.stop if SAUCE
end
