require "./watcher_inotify.c.cr"

module Spy::Watcher
  extend self

  def watch(scope : String, &block)
    inotifiy = INotify.new
    inotifiy.register(scope)
    yield
  end
end
