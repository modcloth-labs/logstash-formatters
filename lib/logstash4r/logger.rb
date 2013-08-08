require 'json'
require 'socket'
require 'logger'

module LogStash4r
  class Logger < ::Logger
    attr_reader :host, :port, :options

    def initialize(host, port)
      @host = host
      @port = port
      super(socket)
    end

    def format_message(severity, time, progname, message)
      event = default_message(severity)

      unless message.is_a?(Hash)
        message = {:@message => message.to_s}
      end

      message.each do |key, value|
        if key == :@fields
          event[:@fields] = value.merge(event[:@fields])
        elsif (key.to_s[0] == '@')
          event[key] = value
        else
          event[:@fields][key] = value
        end
      end

      "#{event.to_json}\n"
    end

    def default_message(severity)
      {
        :@source => ::Socket::gethostname,
        :@timestamp => Time.now,
        :@tags => [],
        :@fields => {severity: severity},
        :@message => ''
      }
    end

    private
    def socket
      @socket ||= TCPSocket.new(host, port)
    end
  end
end
