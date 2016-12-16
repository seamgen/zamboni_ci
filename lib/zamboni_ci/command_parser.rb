require 'optparse'

Options = Struct.new(:hockey_app_id, :bundle_id)

class CommandParser
   def self.parse(options)
      args = Options.new()

      opt_parser = OptionParser.new do |parser|
         parser.banner = "Usage: example"

         parser.on("--h_app_id HOCKEYAPPID", "Hockey app id") do |v|
            args.hockey_app_id = v
         end

         parser.on("--bundle_id BUNDLEID", "provisioning profile's bundle identifier") do |v|
            args.bundle_id = v
         end
      end

      opt_parser.parse!(options)
      return args
   end
end
