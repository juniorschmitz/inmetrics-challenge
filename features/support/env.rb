require 'capybara'
require 'capybara/cucumber'
require 'selenium-webdriver'
require 'rspec'
require 'httparty'
require 'json-schema'

if ENV['API_EXECUTION'].nil?
  Capybara.register_driver :selenium_chrome do |app|
    Capybara::Selenium::Driver.load_selenium
    browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
      opts.args << '--start-maximized'
      opts.args << '--headless' unless ENV['HEADLESS'].nil?
    end
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
  end

  Capybara.configure do |config|
    config.default_driver = :selenium_chrome
    config.app_host = 'http://www.inmrobo.tk'
    config.default_max_wait_time = 12
  end
end
