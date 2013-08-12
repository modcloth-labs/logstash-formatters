require 'logstash4r'
require 'logstash4r/formatters/json'
require 'logstash4r/formatters/json_event'
require 'logstash4r/formatters/plain'
require 'json'
require 'socket'

describe LogStash4r::Logger do
  subject { LogStash4r::Logger.new(socket, formatter) }

  let(:socket) { double('socket').as_null_object }
  let(:now) { Time.now }
  let(:formatter) do
    Module.new do
      def format_message(severity, time, progname, message)
        "#{severity} #{time} #{progname} #{message}"
      end
    end
  end

  before do
    socket.stub(:connect)
    Time.stub(now: now)
  end

  %w(debug info warn error fatal).each do |severity|
    it 'formats the message' do
      subject.should_receive(:format_message).with(severity.upcase, now, nil, 'test')
      subject.send(severity.to_sym, 'test')
    end

    it "writes a plain #{severity} message to the socket" do
      socket.should_receive(:write).with(/#{severity.upcase}/)
      subject.send(severity.to_sym, 'test')
    end
  end
end
