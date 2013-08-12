require 'logstash_formatters/json'
require 'json'

describe LogStashFormatters::Json do
  let(:now) { Time.now }
  let(:severity) { 'HIGH' }
  let(:progname) { 'some name' }

  describe "#format_message" do
    it "formats message as JSON" do
      subject.call(severity, now, progname, {data: 'test'}).should == {
        message: {data: 'test'},
        severity: severity,
        timestamp: now,
      }.to_json
    end
  end
end
