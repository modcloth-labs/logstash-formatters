require 'json'
require 'socket'
require 'logstash-event'

module LogStash4r
  class Logger
    attr_reader :host, :port, :options

    def initialize(host, port, options = {})
      @host = host
      @port = port
      @options = options
    end

    %w(debug info warn error fatal).each do |severity|
      define_method(severity.to_sym) do |message, message_options = {}|
        event = LogStash::Event.new

        message_options = options.merge(message_options)

        message_options.each do |key, value|
          event["@#{key}"] = value
        end

        event.message = message

        socket.write("#{event.to_json}\n")
      end
    end

    private
    def socket
      @socket ||= TCPSocket.new(host, port)
    end
  end
end
