require 'open3'

# Class which starts a blocking process using Open3
class BlockingProcess
  attr_accessor :command, :status

  def execute
    puts "About to execute: #{@command}"

    Open3.popen3 @command do |_stdin, stdout, stderr, wait_thr|
      [stdout, stderr].each do |stream|
        Thread.new do
          until (line = stream.gets).nil?
            puts line
          end
        end
      end
      wait_thr.join
      @status = wait_thr.value.exitstatus

      puts "Exited with status: #{@status}"
    end
  end
end
