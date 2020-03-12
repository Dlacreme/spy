require "yaml"

module Spy
  class Config
    YAML.mapping(
      scope: {type: String, default: "."},
      once: Array(String)?,
      always: Array(String)?,
      async: Array(String)?,
    )

    def pretty_print
      puts "SCOPE: #{self.scope}"
      puts "ONCE: [#{self.once.not_nil!.join(",")}]" if self.once.nil? == false
      puts "ALWAYS: [#{self.always.not_nil!.join(",")}]" if self.always.nil? == false
      puts "ASYNC: [#{self.async.not_nil!.join(",")}]" if self.async.nil? == false
    end

    def self.load_from_yml_file(file_path : String) : Config
      File.open(file_path) { |f| Config.from_yaml(f) }
    end
  end
end
