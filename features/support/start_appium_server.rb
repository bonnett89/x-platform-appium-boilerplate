require_relative 'non_blocking_process'

# Start an appium server with the given command
class StartAppiumServer < NonBlockingProcess
  def initialize(host, port, no_logging)
    @command = "appium -a #{host} -p #{port}"

    @command += ' --log-level warn' if no_logging
  end
end
