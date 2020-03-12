module Spy::Watcher
  class INotify
    lib C
      IN_NONBLOCK = 2048
      IN_MODIFY   =    2
      fun inotify_init1(Int32) : Int64
      fun inotify_add_watch(Int64, UInt8*, Int32) : UInt8*
    end

    def register(target : String)
      puts "register"
      @fd = C.inotify_init1(C::IN_NONBLOCK)
      raise Exception.new("INOTIFY not available") if @fd == -1
      puts @fd
      @watched = C.inotify_add_watch(@fd.not_nil!, target, C::IN_MODIFY)
      puts @watched
    end
  end
end
