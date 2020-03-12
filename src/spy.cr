require "./config.cr"
require "./runner.cr"
require "./watcher.cr"

module Spy
  VERSION = "0.1.0"

  conf = Config.load_from_yml_file("./spy.yml")
  conf.pretty_print

  conf.once.not_nil!.each { |cmd| Runner.run(cmd) } if conf.once.nil? == false

  Watcher.watch(conf.scope) do
    conf.always.not_nil!.each { |cmd| Runner.run(cmd) } if conf.always.nil? == false
  end
end
