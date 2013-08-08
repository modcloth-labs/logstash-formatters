require 'socket'

module LogStash4r
  class Socket

    TRANSPORT_TYPES = {
      udp: :DGRAM,
      tcp: :STREAM,
    }

    def initialize(host, port, type = :udp)
      @socket = ::Socket.new(:INET, TRANSPORT_TYPES.fetch(type))
      @socket.connect(::Socket.pack_sockaddr_in(port, host))
    end

    def write(message)
      socket.write(message)
    ensure
      close
    end

    def close
      socket.close
    end

    private

    attr_reader :socket
  end
end
