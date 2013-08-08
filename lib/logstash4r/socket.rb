require 'socket'

module LogStash4r
  class Socket
    attr_reader :host, :port

    def initialize(host, port)
      @host = host
      @port = port
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
    def socket
      @socket ||= TCPSocket.new(host, port)
    end
  end
end
