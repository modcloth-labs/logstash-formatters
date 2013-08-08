describe LogStash4r::Socket do
  subject { LogStash4r::Socket.new(host, port) }

  let(:host) { 'www.google.com' }
  let(:port) { 80 }
  let(:socket) { double('socket') }

  before do
    ::Socket.stub(:new).and_return(socket)
    socket.stub(:connect)
  end

  context 'write success' do
    it 'returns cleanly' do
      expect do
        subject.should_receive(:write)
        subject.write('test')
      end.to_not raise_error
    end
  end

  context 'write failure' do
    let(:error) { StandardError.new('Failure to write') }

    before do
      socket.stub(:write).and_raise(error)
    end

    it 'reraises exception' do
      expect do
        socket.should_receive(:close)
        subject.write('test')
      end.to raise_error error
    end
  end
end
