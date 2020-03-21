module Spy
  module Runner
    extend self

    def run(command : String)
      puts "Run `#{command}`"
    end

    def run_async(command : String)
      puts "Run Async`#{command}`"
    end

    def run_many(commands : Array(String)?)
      commands.not_nil!.each { |cmd| run(cmd) } if commands.nil? == false
    end

    def run_many_async(commands : Array(String)?)
      commands.not_nil!.each { |cmd| run_async(cmd) } if commands.nil? == false
    end
  end
end
