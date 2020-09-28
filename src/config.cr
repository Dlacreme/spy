require "yaml"

module Spy
  class Config
    YAML.mapping(
      target: {type: String, default: "."},
      once: Array(String)?,
      always: Array(String)?,
    )

    def pretty_print
      puts "TARGET: #{self.target}"
      puts "ONCE: [#{self.once.not_nil!.join(",")}]" if self.once.nil? == false
      puts "ALWAYS: [#{self.always.not_nil!.join(",")}]" if self.always.nil? == false
    end

    def self.load_from_yml_file(file_path : String) : Config
      File.open(file_path) { |f| Config.from_yaml(f) }
    end
  end
end
