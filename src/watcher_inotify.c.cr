module Spy::Watcher
  # inotify API is the lowest API to listen for change events on files & folders
  # Reference: INOTIFY (7)
  lib C
    union Fds
      fd : Int64
      events : Int16
      revents : Int16
    end

    STDIN_FILENO =    0 # STDIN FD
    IN_NONBLOCK  = 2048 # https://sites.uclouvain.be/SystInfo/usr/include/sys/inotify.h.html
    IN_ACCESS    =    1 # "
    IN_MODIFY    =    2 # "
    IN_OPEN      =   20 # "

    POLLIN = 1 # https://code.woboq.org/qt5/include/bits/poll.h.html

    fun inotify_init1(Int32) : Int64
    fun inotify_add_watch(Int64, UInt8*, Int32 | Int32 | Int32) : UInt8*
    fun poll(Fds*, Int32, Int64) : Int64
  end

  class INotify
    @fds : Array(C::Fds) = [] of C::Fds

    def register(target : String)
      @fd = C.inotify_init1(C::IN_NONBLOCK)
      raise Exception.new("INOTIFY not available") if @fd == -1
      @watched = C.inotify_add_watch(@fd.not_nil!, target, C::IN_MODIFY)
      @fds = get_fds

      puts "loop start"
      loop do
        puts "hi?"
        poll_num = C.poll(@fds, 2, -1)
        puts poll_num
        raise Exception.new("Poll error") if poll_num == -1
        if poll_num > 0
          puts "New event"
        else
          puts "no new event"
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
