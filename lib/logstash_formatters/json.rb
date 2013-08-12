require 'logger'

module LogStashFormatters
  class Json < ::Logger::Formatter
    def call(severity, time, progname, message)
      {
        message: message,
        severity: severity,
        timestamp: time
      }.to_json
    end
  end
end
