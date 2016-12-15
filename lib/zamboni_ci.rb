require 'optparse'
require 'curb'
require "./zamboni_ci/command_parser"

arg_array = ARGV

options = CommandParser.parse arg_array

puts options.hockey_app_id
puts options.hockey_auth_token
puts options.hockey_session_token

#hockey_url = "https://rink.hockeyapp.net/manage/apps/#{options[:hockey_app_id]}/app_users/export"

# request UDID list for rocketing app
http = Curl.post("https://rink.hockeyapp.net/manage/apps/444228/app_users/export", {:_method => "post", :authenticity_token => "yxwlg70jsOugsiWyBOGNZTy8e16q2kylCSc7lgRJeig="}) do |http|
   http.headers['Cookie'] = "_hockey_app_session=8b03db099b5495760d2afd24994548d8;"
   http.headers['Content_Type'] = "application/x-www-form-urlencoded"
   http.headers['Accept'] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
end

# Parse hockey UDIDs into an array
existing_hockey_udids = Array.new

index = 0
http.body_str.each_line do |line|
   if index > 0
      parsed = line.split
      existing_hockey_udids.push parsed.first
   end
   index = index + 1      
end

puts existing_hockey_udids

=begin
puts ENV["ZAMBONI_APPLE_ID_EMAIL"]
puts ENV["ZAMBONI_APPLE_ID_PASSWORD"]
puts ENV["ZAMBONI_HOCKEY_EMAIL"]
puts ENV["ZAMBONI_HOCKEY_PASSWORD"]
=end

