module Spy
  module Watcher
    c_bind = CBinding.new(scope)

    extend self

    def watch(scope : String, &block)
      puts "Start watch for : #{scope}"
      c_bind.register
    end
  end
end
