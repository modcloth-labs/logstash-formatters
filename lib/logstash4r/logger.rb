require 'json'
require 'socket'

module Logstash4r
  class Logger
    attr_reader :host, :port

    def initialize(host, port)
      @host = host
      @port = port
    end

    %w(debug info warn error fatal).each do |severity|
      define_method(severity.to_sym) do |message|
        socket.write("#{message.to_json}\n")
      end
    end

    private
    def socket
      @socket ||= TCPSocket.new(host, port)
    end
  end
end
