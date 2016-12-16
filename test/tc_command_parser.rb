require 'test/unit'
require '../lib/zamboni_ci/command_parser'

class TC_command_parser < Test::Unit::TestCase

   def test_no_args
      options = CommandParser.parse []
      assert(options.hockey_app_id == nil, 'hockey_app_id is not nil')
      assert(options.bundle_id == nil, 'bundle is not nil')
   end

   def test_all_args
      options = CommandParser.parse %w[--h_app_id 123456 --bundle_id com.bundle.id]
      assert(options.hockey_app_id == "123456", 'hockey_app_id not parsed')
      assert(options.bundle_id == "com.bundle.id", 'bundle_id not parsed')
   end

   def test_only_app_id
      options = CommandParser.parse %w[--h_app_id 123456]
      assert(options.hockey_app_id == "123456", 'hockey_app_id not parsed')
      assert(options.bundle_id == nil, 'bundle_id not nil')
   end

   def test_only_bundle_id
      options = CommandParser.parse %w[--bundle_id com.bundle.id]
      assert(options.hockey_app_id == nil, 'hockey_app_id not nil')
      assert(options.bundle_id == "com.bundle.id", 'bundle_id id not parsed')
   end

   def test_all_args_re_order
      options = CommandParser.parse %w[--bundle_id com.bundle.id --h_app_id 123456]
      assert(options.hockey_app_id == "123456", 'hockey_app_id not parsed')
      assert(options.bundle_id == "com.bundle.id", 'bundle_id not parsed')
   end

end
