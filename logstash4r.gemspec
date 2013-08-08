Gem::Specification.new do |s|
  s.name = 'logstash4r'
  s.version = '0.0.2'
  s.date = '2013-08-08'
  s.summary = 'Logstash4r'
  s.description= 'Logstash logger for ruby'
  s.authors = ['Jesse Szwedko', 'Sheena McCoy']
  s.email = ['j.szwedko@modcloth.com', 'sp.mccoy@modcloth.com']
  s.files = ['lib/logstash4r.rb']
  s.homepage = ''
  s.license = 'MIT'

  s.add_runtime_dependency 'logstash-event'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rake'
end
