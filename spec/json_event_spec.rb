require 'logstash_formatters/json_event'
require 'json'
require 'socket'

describe LogStashFormatters::JsonEvent do
  let(:now) { Time.now }
  let(:severity) { 'HIGH' }
  let(:progname) { 'some name' }

  describe "#format_message" do
    it "formats message as JSON" do
      subject.call(severity, now, progname, {:@message => 'test'}).should == {
        :@source => ::Socket::gethostname,
        :@timestamp => now,
        :@tags => [],
        :@fields => {severity: severity},
        :@message => 'test'
      }.to_json + "\n"
    end
  end
end
