require 'json'
require 'socket'
require 'logger'
require 'logstash4r/socket'
require 'logstash4r/formatters/plain'
require 'logstash4r/formatters/json'
require 'logstash4r/formatters/json_event'

module LogStash4r
  class Logger < ::Logger
    def initialize(host, port, socket_type = :udp, format = :plain)
      super(LogStash4r::Socket.new(host, port, socket_type))

      case format
      when :plain
        extend LogStash4r::Formatters::Plain
      when :json
        extend LogStash4r::Formatters::Json
      when :json_event
        extend LogStash4r::Formatters::JsonEvent
      end
    end
  end
end
