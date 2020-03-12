module Spy
  module Watcher
    extend self

    def watch(scope : String, &block)
      puts "Start watch for : #{scope}"
      yield
    end
  end
end
