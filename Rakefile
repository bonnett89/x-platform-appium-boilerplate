require 'rake'

require_relative './features/support/appium_server'
require_relative './features/support/cucumber_bdd'

desc 'Start an Appium Server'
task :start_appium, [:block] do |_t, args|
  # TODO: Set url for Appium server
  AppiumServer.start('0.0.0.0', '4723')

  block unless args[:block] && args[:block] == 'false'
end

# TODO: Take a profile argument as well
desc 'Run Cucumber'
task :cucumber, [:platform] do |_t, args|
  platform = args[:platform]
  appium_server_url = AppiumServer.url
  CucumberBDD.new(platform, appium_server_url).execute
end

desc 'Run iOS Cucumber tests'
task :ios_cucumber do
  ENV['PLATFORM_NAME'] = 'iOS'
  Rake::Task[:start_appium].invoke('false')
  Rake::Task[:cucumber].invoke('ios')
end

desc 'Run Android Cucumber tests'
task :android_cucumber do
  ENV['PLATFORM_NAME'] = 'Android'
  Rake::Task[:start_appium].invoke('false')
  Rake::Task[:cucumber].invoke('android')
end

def block
  puts 'Hit CTRL-C when you are done.'

  loop do
    sleep 0.1
    puts '...looping...'
    Signal.trap('INT') do
      abort('She cannot take any more of this, Captain!')
    end
  end
end

at_exit do
  AppiumServer.stop
end
