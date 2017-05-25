require 'rake'
require 'uri'

require_relative './features/support/appium_server'
require_relative './features/support/cucumber_bdd'

desc 'Start an Appium Server'
task :start_appium, [:block] do |_t, args|
  appium_url = URI(get_server_configuration['appium_url'])
  appium_host = appium_url.host
  appium_port = appium_url.port
  AppiumServer.start(appium_host, appium_port)

  block unless args[:block] && args[:block] == 'false'
end

desc 'Run Cucumber'
task :cucumber, %i[platform profile] do |_t, args|
  platform = args[:platform]
  profile = args[:profile]
  appium_server_url = AppiumServer.url
  CucumberBDD.new(platform, profile, appium_server_url).execute
end

desc 'Run iOS Cucumber tests'
task :ios_cucumber, [:profile] do |_t, args|
  Rake::Task[:start_appium].invoke('false')
  Rake::Task[:cucumber].invoke('ios', args[:profile])
end

desc 'Run Android Cucumber tests'
task :android_cucumber, [:profile] do |_t, args|
  Rake::Task[:start_appium].invoke('false')
  Rake::Task[:cucumber].invoke('android', args[:profile])
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

def get_server_configuration
  config_path = './config/server_config.yml'
  if File.exist?(config_path)
    YAML.load(File.read(config_path))
  else
    abort 'Cannot find server configuration file, please add in the config directory.'
  end
end

at_exit do
  AppiumServer.stop
end
