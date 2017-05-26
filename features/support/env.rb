require 'appium_lib'
require 'cucumber/ast'
require 'uri'

require_relative 'appium_world'
require_relative '../pages/page_factory'

# raise 'NO PLATFORM NAME environment variable' if ENV['PLATFORM_NAME'].nil?

platform = ENV['PLATFORM'].downcase

appium_file_path = "./config/#{platform}/appium.txt"
appium_url = URI("#{ENV['APPIUM_SERVER_URL']}/wd/hub")

caps = Appium.load_settings(file: appium_file_path, verbose: true)[:caps]

driver = Appium::Driver.new(caps: caps, appium_lib: { port: appium_url.port })

Appium.promote_appium_methods AppiumWorld

World do
  page_factory = PageFactory.new(platform, driver)
  AppiumWorld.new(driver, page_factory)
end

After do
  app_close
end
