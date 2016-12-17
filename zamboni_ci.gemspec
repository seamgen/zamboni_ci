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
   s.add_runtime_dependency "nokogiri",
      ["= 1.6.8"]
   s.add_runtime_dependency "curb",
      ["= 0.9.3"]
   s.add_runtime_dependency "spaceship",
      ["= 0.39.0"]
   s.add_runtime_dependency "ruby-keychain",
      ["= 0.3.2"]

end
