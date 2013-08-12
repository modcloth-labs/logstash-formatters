require 'logstash4r/formatters/plain'

describe LogStash4r::Formatters::Plain do
  let(:now) { Time.now }
  let(:severity) { 'HIGH' }
  let(:progname) { 'some name' }

  subject do
    Class.new do
      include LogStash4r::Formatters::Plain
    end.new
  end

  describe "#format_message" do
    it "formats message as JSON" do
      subject.format_message(severity, now, progname, 'test').should =~ /#{severity} test/
    end
  end
end
