module LogStash4r
  module Formatters
    module Json
      def format_message(severity, time, progname, message)
        {
          message: message,
          severity: severity,
          timestamp: time
        }.to_json
      end
    end
  end
end
