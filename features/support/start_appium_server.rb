require_relative 'non_blocking_process'

# Start an appium server with the given command
class StartAppiumServer < NonBlockingProcess
  def initialize(host, port)
    @command = "appium -a #{host} -p #{port}"
  end
end
