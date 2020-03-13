module Spy::Watcher
  # inotify API is the lowest API to listen for change events on files & folders
  # Reference: INOTIFY (7)
  lib C
    union Fds
      fd : Int64
      events : Int16
      revents : Int16
    end

    STDIN_FILENO =          0 # STDIN FD
    IN_NONBLOCK  =     0o4000 # https://sites.uclouvain.be/SystInfo/usr/include/sys/inotify.h.html
    IN_ACCESS    = 0x00000001 # "
    IN_MODIFY    = 0x00000002 # "
    IN_OPEN      = 0x00000020 # "
    POLLIN       =      0x001 # https://code.woboq.org/qt5/include/bits/poll.h.html

    fun inotify_init1(Int32) : Int64
    fun inotify_add_watch(Int64, UInt8*, UInt32) : UInt8*
    fun poll(Fds*, Int32, Int64) : Int64
  end

  class INotify
    @fds : Array(C::Fds) = [] of C::Fds

    def register(target : String, &block)
      @fd = C.inotify_init1(C::IN_NONBLOCK)
      raise Exception.new("INOTIFY not available") if @fd == -1
      @watched = C.inotify_add_watch(@fd.not_nil!, target, C::IN_MODIFY | C::IN_OPEN | C::IN_ACCESS)
      @fds = get_fds

      puts "Start watching '#{target}'"
      loop do
        poll_num = C.poll(@fds, 2, -1)
        puts poll_num
        raise Exception.new("Poll error") if poll_num == -1
        if poll_num > 0
          puts "New event"
          yield
        end
      end
    end

    private def get_fds : Array(C::Fds)
      console_input = C::Fds.new
      console_input.fd = C::STDIN_FILENO
      console_input.events = C::POLLIN

      inotify_input = C::Fds.new
      inotify_input.fd = @fd.not_nil!
      inotify_input.events = C::POLLIN

      [console_input, inotify_input] of C::Fds
    end
  end
end
