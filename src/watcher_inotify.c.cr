module Spy::Watcher
  # inotify API is the lowest API to listen for change events on files & folders
  # Reference: INOTIFY (7)
  lib C
    struct Fds
      fd : Int32
      events : Int16
      revents : Int16
    end

    STDIN_FILENO =    0
    IN_NONBLOCK  = 2048 # https://sites.uclouvain.be/SystInfo/usr/include/sys/inotify.h.html
    IN_MODIFY    =    2 # "
    POLLIN       =    1 # https://code.woboq.org/qt5/include/bits/poll.h.html

    fun inotify_init1(Int32) : Int32
    fun inotify_add_watch(Int64, UInt8*, UInt32) : Int32
    fun poll(Fds*, Int32, Int64) : Int32
  end

  class INotify
    # @@fd : Int64 = -1
    # unitialized @watched : Pointer(UInt8) = pointerof(@fd)
    # @@fds : Array(C::Fds) = [] of C::Fds

    def register(target : String, &block)
      fd = C.inotify_init1(C::IN_NONBLOCK)
      raise Exception.new("INOTIFY not available") if fd == -1
      watched = C.inotify_add_watch(fd, target, C::IN_MODIFY)
      fds = get_fds(fd)
      loop do
        puts "Start watching '#{target}'"
        poll_num = C.poll(fds, fds.size, -1)
        raise Exception.new("Poll error") if poll_num == -1
        yield if poll_num > 0
      end
    end

    private def get_fds(fd) : Array(C::Fds)
      console_input = C::Fds.new
      console_input.fd = C::STDIN_FILENO
      console_input.events = C::POLLIN

      inotify_input = C::Fds.new
      inotify_input.fd = fd
      inotify_input.events = C::POLLIN

      [console_input, inotify_input] of C::Fds
    end
  end
end
