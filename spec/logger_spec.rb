require 'logstash4r'

describe LogStash4r::Logger do
  subject { LogStash4r::Logger.new(host, port) }

  let(:host) { double('host') }
  let(:port) { double('port') }
  let(:socket) { double('socket').as_null_object }
  let(:now) { Time.now }

  before do
    TCPSocket.stub(new: socket)
    Time.stub(now: now)
  end

  %w(debug info warn error fatal).each do |severity|
    it { should respond_to(severity.to_sym) }

    it 'writes message to socket' do
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
