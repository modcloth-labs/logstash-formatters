require 'logstash4r'

describe LogStash4r::Logger do
  subject { LogStash4r::Logger.new(host, port) }

  let(:host) { 'localhost' }
  let(:port) { '80' }
  let(:socket) { double('socket').as_null_object }
  let(:now) { Time.now }

  before do
    ::Socket.stub(:new).and_return(socket)
    socket.stub(:connect)
    Time.stub(now: now)
  end

  context 'plain format' do
    %w(udp tcp).each do |socket_type|
      subject { LogStash4r::Logger.new(host, port, socket_type.to_sym, LogStash4r::Formatters::Plain) }

      %w(debug info warn error fatal).each do |severity|
        it "writes a plain #{severity} message to the socket #{socket_type}" do
          socket.should_receive(:write).with(/#{severity.upcase} test/)
          subject.send(severity.to_sym, 'test')
        end
      end
    end

    context 'json format' do
      %w(udp tcp).each do |socket_type|
        subject { LogStash4r::Logger.new(host, port, socket_type.to_sym, LogStash4r::Formatters::Json) }

        %w(debug info warn error fatal).each do |severity|
          it "writes a json #{severity} message to the socket #{socket_type}" do
            socket.should_receive(:write).with({
              message: {data: 'test'},
              severity: severity.upcase,
              timestamp: now,
            }.to_json)
            subject.send(severity.to_sym, {data: 'test'})
          end
        end
      end

      context 'json event format' do
        %w(udp tcp).each do |socket_type|
          subject { LogStash4r::Logger.new(host, port, socket_type.to_sym, LogStash4r::Formatters::JsonEvent) }

          %w(debug info warn error fatal).each do |severity|
            it "writes a json #{severity} message to the socket #{socket_type}" do
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
  end
end
