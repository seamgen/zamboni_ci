require 'optparse'

Options = Struct.new(:hockey_app_id, :bundle_id, :hockey_account, :apple_account)

class CommandParser
   def self.parse(options)
      args = Options.new()

      opt_parser = OptionParser.new do |parser|
         parser.banner = "Usage: all parameters are required"

         parser.on("--h_app_id HOCKEYAPPID", "Hockey app id") do |v|
            args.hockey_app_id = v
         end

         parser.on("--bundle_id BUNDLEID", "provisioning profile's bundle identifier") do |v|
            args.bundle_id = v
         end

         parser.on("--apple_account APPLEACCOUNT", "email used to log into the apple provisioning portal") do |v|
            args.apple_account = v
         end

         parser.on("--hockey_account HOCKEYACCOUNT", "email used to log into hockeyapp") do |v|
            args.hockey_account = v
         end

         parser.on("-h", "Print Help") do
            puts parser
            exit
         end
      end

      opt_parser.parse!(options)
      return args
   end
end
