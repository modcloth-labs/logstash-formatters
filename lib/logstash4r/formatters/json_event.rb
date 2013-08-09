module LogStash4r
  module Formatters
    module JsonEvent
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
    end
  end
end
