require 'logger'
require 'logstash4r/formatters/plain'

module LogStash4r
  class Logger < ::Logger
    def initialize(socket, formatter = LogStash4r::Formatters::Plain)
      extend formatter

      super(socket)
    end
  end
end
