require 'test/unit'
require '../lib/zamboni_ci/command_parser'

class TC_command_parser < Test::Unit::TestCase

   def test_no_args
      options = CommandParser.parse []
      assert(options.hockey_app_id == nil, 'hockey_app_id is not nil')
      assert(options.prov_profile_name == nil, 'bundle is not nil')
   end

   def test_all_args
      options = CommandParser.parse %w[--h_app_id 123456 --prov_profile_name Profile --apple_account jmoyers14@gmail.com --hockey_account hockey@gmail.com]
      assert(options.hockey_app_id == "123456", 'hockey_app_id not parsed')
      assert(options.prov_profile_name == "Profile", 'prov_profile_name not parsed')
      assert(options.apple_account == "jmoyers14@gmail.com", "apple_account not parsed")
      assert(options.hockey_account == "hockey@gmail.com", "hockey_account not parsed")
   end

   def test_only_app_id
      options = CommandParser.parse %w[--h_app_id 123456]
      assert(options.hockey_app_id == "123456", 'hockey_app_id not parsed')
      assert(options.prov_profile_name == nil, 'prov_profile_name not nil')
   end

   def test_all_args_re_order
      options = CommandParser.parse %w[--hockey_account hockey@gmail.com --prov_profile_name Profile --apple_account jmoyers14@gmail.com --h_app_id 123456]
      assert(options.hockey_app_id == "123456", 'hockey_app_id not parsed')
      assert(options.prov_profile_name == "Profile", 'prov_profile_name not parsed')
      assert(options.apple_account == "jmoyers14@gmail.com", "apple_account not parsed")
      assert(options.hockey_account == "hockey@gmail.com", "hockey_account not parsed")
   end

end
