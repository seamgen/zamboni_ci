require 'optparse'
require 'curb'
require 'spaceship'
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

hockey_devices = DeviceParser.parse_hockey(http.body_str)

# Log into Apple Portal
Spaceship::Portal.login(ENV["ZAMBONI_APPLE_ID_EMAIL"], ENV["ZAMBONI_APPLE_ID_PASSWORD"])

# Find provisioning profile
all_profiles = Spaceship::Portal.provisioning_profile.find_by_bundle_id(options.bundle_id)
profile = all_profiles.last

# Find devices to add
spaceship_devices = DeviceParser.parse_spaceship(profile.devices)

devices_to_add = DeviceParser.find_new_devices(hockey_devices, spaceship_devices)

# Print devices to add
devices_to_add.each do |device|
   puts "add: " + device.name + " " + device.udid
end
