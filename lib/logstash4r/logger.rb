require 'json'
require 'socket'
require 'logger'
require 'logstash4r/socket'
require 'logstash4r/formatters/plain'
require 'logstash4r/formatters/json'
require 'logstash4r/formatters/json_event'

module LogStash4r
  class Logger < ::Logger
    def initialize(host, port, socket_type = :udp, formatter = LogStash4r::Formatters::Plain)
      extend formatter

      super(LogStash4r::Socket.new(host, port, socket_type))
    end
  end
end
