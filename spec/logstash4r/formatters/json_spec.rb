require 'logstash4r/formatters/json'
require 'json'

describe LogStash4r::Formatters::Json do
  let(:now) { Time.now }
  let(:severity) { 'HIGH' }
  let(:progname) { 'some name' }

  subject do
    Class.new do
      include LogStash4r::Formatters::Json
    end.new
  end

  describe "#format_message" do
    it "formats message as JSON" do
      subject.format_message(severity, now, progname, {data: 'test'}).should == {
        message: {data: 'test'},
        severity: severity,
        timestamp: now,
      }.to_json
    end
  end
end
