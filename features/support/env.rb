require 'appium_lib'
require 'cucumber/ast'

require_relative 'appium_world'
require_relative '../pages/page_factory'

# raise 'NO PLATFORM NAME environment variable' if ENV['PLATFORM_NAME'].nil?

platform = ENV['PLATFORM'].downcase

appium_file_path = "./config/#{platform}/appium.txt"

caps = Appium.load_settings(file: appium_file_path, verbose: true)

driver = Appium::Driver.new(caps)
Appium.promote_appium_methods AppiumWorld

World do
  page_factory = PageFactory.new(platform, driver)
  AppiumWorld.new(driver, page_factory)
end

After do
  app_close
end
