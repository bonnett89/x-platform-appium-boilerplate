require 'httparty'
require 'tty-spinner'

require_relative 'start_appium_server'

# Appium server class
class AppiumServer < StartAppiumServer
  def self.start(host, port, no_logging)
    @host = host
    @port = port
    @no_logging = no_logging
    @spinner = TTY::Spinner.new('[:spinner] Starting Appium server ', format: :dots)
    if running?
      puts "Appium server already running at #{url}"
    else
      boot_server
      @spinner.success('(successful)')
    end
  end

  def self.boot_server
    @command = StartAppiumServer.new(@host, @port, @no_logging)
    @command.execute
    @spinner.auto_spin
    loop do
      break if running?
    end
  end

  def self.url
    "http://#{@host}:#{@port}"
  end

  def self.stop
    @command.close unless @command.nil?
    puts 'Appium server stopped'
  end

  def self.running?
    status_url = "#{url}/wd/hub/status"
    begin
      HTTParty.get(status_url).response.code.to_i.equal?(200)
      sleep 1
    rescue
      false
    end
  end
end
