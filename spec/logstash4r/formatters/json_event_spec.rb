require 'logstash4r/formatters/json_event'
require 'json'
require 'socket'

describe LogStash4r::Formatters::JsonEvent do
  let(:now) { Time.now }
  let(:severity) { 'HIGH' }
  let(:progname) { 'some name' }

  subject do
    Class.new do
      include LogStash4r::Formatters::JsonEvent
    end.new
  end

  describe "#format_message" do
    it "formats message as JSON" do
      subject.format_message(severity, now, progname, {:@message => 'test'}).should == {
        :@source => ::Socket::gethostname,
        :@timestamp => now,
        :@tags => [],
        :@fields => {severity: severity.upcase},
        :@message => 'test'
      }.to_json + "\n"
    end
  end
end
