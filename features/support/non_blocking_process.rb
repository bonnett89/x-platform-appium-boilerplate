# Class to execture a non blocking process i.e. Appium Server
class NonBlockingProcess
  attr_accessor :command, :status, :pid

  def execute
    puts "About to execute: #{@command}"

    @stdin, @stdout, @stderr, wait_thr = Open3.popen3(@command)

    [@stdout, @stderr].each do |stream|
      Thread.new do
        until (line = stream.gets).nil?
          puts line
        end
      end
    end

    @pid = wait_thr[:pid]
    @pid
  end

  def close
    @stdin.close
    @stdout.close
    @stderr.close

    puts "About to kill process: #{@pid}"

    `kill -9 #{@pid}`
  end
end
