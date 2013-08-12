Gem::Specification.new do |s|
  s.name = 'logstash-formatters'
  s.version = '1.0.0'
  s.date = '2013-08-12'
  s.summary = 'Logstash Formatters'
  s.description= 'Logstash formatters for Ruby Logger'
  s.authors = ['Jesse Szwedko', 'Sheena McCoy']
  s.email = ['j.szwedko@modcloth.com', 'sp.mccoy@modcloth.com']
  s.files = ['lib/logstash_formatters.rb']
  s.homepage = ''
  s.license = 'MIT'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rake'
end
