module LogStash4r
  module Formatters
    module Plain
      def format_message(severity, time, progname, message)
        "#{time} #{severity} #{message}"
      end
    end
  end
end
