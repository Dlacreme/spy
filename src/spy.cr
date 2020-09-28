require "./config.cr"
require "./runner.cr"
require "./watcher.cr"

module Spy
  VERSION = "0.1.0"

  conf = Config.load_from_yml_file("./spy.yml")

  # Run `once` tasks
  Runner.run_many conf.once

  # Start watching for file events
  Watcher.watch(conf.target) do
    Runner.run_many conf.always
  end
end
