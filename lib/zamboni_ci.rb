require 'optparse'
require 'curb'
require "./zamboni_ci/command_parser"
require "./zamboni_ci/device_parser"

#parse command line arguments
arg_array = ARGV
options = CommandParser.parse arg_array

hockey_url = "https://rink.hockeyapp.net/manage/apps/#{options.hockey_app_id}/app_users/export"

# request UDID list for rocketing app
http = Curl.post(hockey_url, {:_method => "post", :authenticity_token => options.hockey_auth_token}) do |http|
   http.headers['Cookie'] = "_hockey_app_session=#{options.hockey_session_token};"
   http.headers['Content_Type'] = "application/x-www-form-urlencoded"
   http.headers['Accept'] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
end

hockey_devices = DeviceParser.parse(http.body_str)

# Parse hockey UDIDs into an array
=begin
puts ENV["ZAMBONI_APPLE_ID_EMAIL"]
puts ENV["ZAMBONI_APPLE_ID_PASSWORD"]
puts ENV["ZAMBONI_HOCKEY_EMAIL"]
puts ENV["ZAMBONI_HOCKEY_PASSWORD"]
=end

