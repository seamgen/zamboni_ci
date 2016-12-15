HockeyDevice = Struct.new(:name, :udid)

class DeviceParser
   def self.parse(device_str)
      # Parse hockey UDIDs into an array
      existing_hockey_udids = Array.new

      device_str.each_line do |line|
         udid, *name_array = line.split
         if udid != "Device"
            name = name_array.join(" ").gsub("\n", "")
            device = HockeyDevice.new(name, udid)
            existing_hockey_udids.push device 
         end
      end

      return existing_hockey_udids
   end
end
