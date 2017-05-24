This project uses rake tasks for various purposes, the main one of these being to run the tests for either iOS and Android. This document explains some of the concepts and how this was achieved.

### Rakefile

The Rakefile contains a number of tasks, most important of which being `ios_cucumber` and `android_cucumber`. The tasks themselves actually require other tasks to be run, lets take `ios_cucumber`:
```ruby
desc 'Run iOS Cucumber tests'
task :ios_cucumber, [:profile] do |_t, args|
  Rake::Task[:start_appium].invoke('false')
  Rake::Task[:cucumber].invoke('ios', args[:profile])
end
```
As we can see the task takes one optional argument: `:profile` (see [Cucumber Profiles](https://github.com/cucumber/cucumber/wiki/cucumber.yml)) it then runs two tasks: `:start_appium` and `:cucumber`. These tasks are quite self explanatory. One starts and appium server and the other runs cucumber. The `:cucumber` task does some interesting things, we use the `.invoke` method to pass both the `platform` (in this case **iOS**) and any `profile` that has been added. Lets look at the `:start_appium` task.

```ruby
desc 'Start an Appium Server'
task :start_appium, [:block] do |_t, args|
  # TODO: Set url for Appium server
  AppiumServer.start('0.0.0.0', '4723')

  block unless args[:block] && args[:block] == 'false'
end
```

As we can see this takes one argument of `:block` it then uses a method from the `AppiumServer` class to start an appium server at the given host & port.

The Cucumber task:
```ruby
desc 'Run Cucumber'
task :cucumber, %i[platform profile] do |_t, args|
  platform = args[:platform]
  profile = args[:profile]
  appium_server_url = AppiumServer.url
  CucumberBDD.new(platform, profile, appium_server_url).execute
end
```

This task takes in two arguments: `platform` (platform under test) and `profile`. It then executes a Cucumber command using the `CucumberBDD` class with the given arguments.

`android_cucumber` works in the same way as above.

### Deeper look at the classes and processes

In the support folder there is a number of helper classes. Firstly we will focus on `blocking_procces.rb` and `non_blocking_process.rb`. Both of these classes enable us to run terminal commands direct from the Rakefile. Name wise they are fairly self descriptive, Non-Blocking allows us to start a process which does not block other processes from being started. In this case we are using it for spinning up an Appium server, another use could be to start a Mock server. Blocking similarly does what it sounds like, after starting a process it blocks any others from starting. We use this to start Cucumber running, we don't want anything to interupt this process from happening. Here is a nice article on [Blocking versus Non Blocking Code](https://medium.com/@hengkiardo/blocking-versus-non-blocking-code-d3bde835062f) by Hengki Sihombing.

We are using a module of Ruby called `Open3`, this grants us access to the `stdin, stdout, stderr` and a thread to wait the child process when running another program. For some more info on [Open3 click here](https://ruby-doc.org/stdlib-1.9.3/libdoc/open3/rdoc/Open3.html#method-c-popen3).

#### AppiumServer Class

This class does a number of important things. Firstly we detect if an Appium server is already running at the given url, using the `running?` method. If this is not the case then we create an `@command` object using the `StartAppiumServer` class. All this class does is initiate and return the `@command` object using the given `host & port` in an appium format: `appium -a #{host} -p #{port)`. As the `StartAppiumServer` class inherits from the `NonBlockingProcess` class we can use the execute method to then execute our command. In turn starting an Appium server.

#### CucumberBDD Class

This Class has only one job, it initialises and ruturns another `@command` object this time in the Cucumber format:
`cucumber -c PLATFORM=#{platform} APPIUM_SERVER_URL=#{appium_server_url}`. An `unless` argument is then used to determine if a `profile` is present and if so it is added to the `@command` object. This class inherits from the `BlockingCommand` which allows us to use the `execute` method from that class for running the Cucumber process.
