require 'optparse'

Options = Struct.new(:hockey_app_id, :hockey_auth_token, :hockey_session_token)

class CommandParser
   def self.parse(options)
      args = Options.new()

      opt_parser = OptionParser.new do |parser|
         parser.banner = "Usage: example"

         parser.on("--h_app_id HOCKEYAPPID", "apple id with itunes connect access.") do |v|
            args.hockey_app_id = v
         end

         parser.on("--h_auth_token HOCKEYAUTHTOKEN", "hockey authentication token") do |v|
            args.hockey_auth_token = v
         end

         parser.on("--h_session_token HOCKEYSESSIONTOKEN", "hockey app session token") do |v|
            args.hockey_session_token = v
         end
      end

      opt_parser.parse!(options)
      return args
   end
end
