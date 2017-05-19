require_relative 'blocking_process'
# Run Cucumber Class
class CucumberBDD < BlockingProcess
  def initialize(platform, profile, appium_server_url)
    @command = "cucumber -c PLATFORM=#{platform} APPIUM_SERVER_URL=#{appium_server_url}"

    @command += "--profile#{profile}" unless profile.nil?
  end
end
