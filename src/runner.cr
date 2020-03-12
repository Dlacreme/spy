module Spy
  module Runner
    extend self

    def run(command : String)
      puts "Run `#{command}`"
    end
  end
end
