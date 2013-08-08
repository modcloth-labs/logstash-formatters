require 'logstash4r'

describe Logstash4r::Logger do
  subject { Logstash4r::Logger.new(host, port) }

  let(:host) { double('host') }
  let(:port) { double('port') }
  let(:socket) { double('socket') }

  before do
    TCPSocket.stub(:new).and_return(socket)
  end

  %w(debug info warn error fatal).each do |severity|
    it { should respond_to(severity.to_sym) }

    it 'writes message to socket' do
      socket.should_receive(:write).with("{\"message\":\"test\"}\n")
      subject.send(severity.to_sym, {message: 'test'})
    end
  end
end
