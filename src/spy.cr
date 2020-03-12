require "./config.cr"

module Spy
  VERSION = "0.1.0"

  conf = Config.load_from_yml_file("./spy.yml")
  conf.pretty_print
end
