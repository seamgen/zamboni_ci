Gem::Specification.new do |s|
   s.name = 'zamboni_ci'
   s.version = '0.0.0'
   s.executables << 'zamboni_ci'
   s.date    = '2016-12-15'
   s.summary = 'hockeyapp to provisioning profile device udid automation'
   s.description = 'hello world'
   s.authors = ["Jeremy Moyers"]
   s.email = 'jmoyers@seamgen.com'
   s.files = ["./lib/zamboni_ci.rb", "./lib/zamboni_ci/command_parser.rb", "./lib/zamboni_ci/device_parser.rb", "./lib/zamboni_ci/hockey_crawler.rb", "./test/tc_command_parser.rb", "./test/tc_device_parser.rb", "./test/tc_zamboni_ci.rb"]
end
