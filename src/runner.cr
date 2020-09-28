module Spy
  module Runner
    extend self

    COLOROFF = "\033[0m"    # Text Reset
    BLACK    = "\033[0;30m" # Black
    RED      = "\033[0;31m" # Red
    GREEN    = "\033[0;32m" # Green
    YELLOW   = "\033[0;33m" # Yellow
    BLUE     = "\033[0;34m" # Blue
    PURPLE   = "\033[0;35m" # Purple
    CYAN     = "\033[0;36m" # Cyan
    WHITE    = "\033[0;37m" # White

    def run_many(commands : Array(String)?)
      return unless commands.nil? == false && commands.not_nil!.size > 0
      p = Process.fork do
        commands.not_nil!.each do |cmd|
          print(" > ", BLUE, cmd)
          puts PURPLE
          system cmd
          puts "#{COLOROFF}\n"
        end
      end
      p.wait
    end

    def print(prefix, color, content)
      puts "#{color}#{prefix}#{content}#{COLOROFF}"
    end
  end
end
