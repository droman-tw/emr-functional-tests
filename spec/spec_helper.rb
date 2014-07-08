require 'rubygems'
require 'bundler'
Bundler.require(:default)
require "capybara-screenshot"
require "capybara-screenshot/rspec"

ActiveSupport::Dependencies.autoload_paths += [File.expand_path("../support", __FILE__), File.expand_path("../pages", __FILE__)]

Capybara.default_driver = :selenium
Capybara.javascript_driver = :selenium
Capybara.app_host = Settings.root_url
Capybara.run_server = false
Capybara.default_wait_time = 10
Capybara.ignore_hidden_elements = false
Capybara.save_and_open_page_path = File.expand_path("../../screenshots", __FILE__)

headless = Headless.new
Debugger.start

RSpec.configure do |config|
    config.include AppsAwareness
    config.before(:all) do
        Selenium::WebDriver::Firefox::Binary.path=Settings.firefox_path
        headless.start
    end
    config.after(:all) do
        headless.destroy
    end
end
