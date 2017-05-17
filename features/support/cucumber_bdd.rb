require_relative 'blocking_process'
# Run Cucumber Class
class CucumberBDD < BlockingProcess
  @command = nil
  @platform = nil

  def initialize(platform, appium_server_url)
    @platform = platform
    @command = "cucumber -c PLATFORM=#{platform} APPIUM_SERVER_URL=#{appium_server_url}"
  end
end
