require 'logstash4r'
require 'logstash4r/formatters/json'
require 'logstash4r/formatters/json_event'
require 'logstash4r/formatters/plain'
require 'json'
require 'socket'

describe LogStash4r::Logger do
  subject { LogStash4r::Logger.new(socket) }

  let(:socket) { double('socket').as_null_object }
  let(:now) { Time.now }

  before do
    socket.stub(:connect)
    Time.stub(now: now)
  end

  context 'plain format' do
    subject { LogStash4r::Logger.new(socket, LogStash4r::Formatters::Plain) }

    %w(debug info warn error fatal).each do |severity|
      it "writes a plain #{severity} message to the socket" do
        socket.should_receive(:write).with(/#{severity.upcase} test/)
        subject.send(severity.to_sym, 'test')
      end
    end
  end

  context 'json format' do
    subject { LogStash4r::Logger.new(socket, LogStash4r::Formatters::Json) }

    %w(debug info warn error fatal).each do |severity|
      it "writes a json #{severity} message to the socket" do
        socket.should_receive(:write).with({
          message: {data: 'test'},
          severity: severity.upcase,
          timestamp: now,
        }.to_json)
        subject.send(severity.to_sym, {data: 'test'})
      end
    end

    context 'json event format' do
      subject { LogStash4r::Logger.new(socket, LogStash4r::Formatters::JsonEvent) }

      %w(debug info warn error fatal).each do |severity|
        it "writes a json #{severity} message to the socket" do
          socket.should_receive(:write).with({
            :@source => ::Socket::gethostname,
            :@timestamp => now,
            :@tags => [],
            :@fields => {severity: severity.upcase},
            :@message => 'test'
          }.to_json + "\n")
          subject.send(severity.to_sym, {:@message => 'test'})
        end
      end
    end
  end
end
