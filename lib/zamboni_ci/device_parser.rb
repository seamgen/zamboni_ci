require 'set'

class ZDevice
   attr_reader :name, :udid   

   def initialize name, udid
      @name = name
      @udid = udid
   end

   def ==(another_zdevice)
      self.udid == another_zdevice.udid
   end

   def eql?(another_zdevice)
      self.udid == another_zdevice.udid
   end

   def hash
      @udid.hash
   end

end

class DeviceParser
   def self.parse_hockey(device_str)
      # Parse hockey UDIDs into an array
      existing_hockey_udids = Array.new

      device_str.each_line do |line|
         udid, *name_array = line.split
         if udid != "Device"
            name = name_array.join(" ").gsub("\n", "")
            device = ZDevice.new(name, udid)
            existing_hockey_udids.push device 
         end
      end

      return existing_hockey_udids
   end

   def self.parse_spaceship(device_list)
      zdevices = Array.new   
   
      device_list.each do |device|
         zdevice = ZDevice.new(device.name, device.udid)
         zdevices.push zdevice
      end

      return zdevices
   end
   
   def self.find_new_devices(device_list1, device_list2)
      unique = device_list1.to_set - device_list2.to_set
      return unique.to_a
   end
end
