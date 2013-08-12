Gem::Specification.new do |s|
  s.name = 'logstash-formatters'
  s.version = '1.0.0'
  s.authors = ['Jesse Szwedko', 'Sheena McCoy']
  s.email = ['j.szwedko@modcloth.com', 'sp.mccoy@modcloth.com']
  s.description= 'Logstash formatters for Ruby Logger'
  s.summary = 'Logstash Formatters'
  s.homepage = ''
  s.license = 'MIT'

  s.files = ['lib/logstash_formatters.rb']
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rake'
end
