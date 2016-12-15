require 'test/unit'
require '../lib/zamboni_ci/device_parser'

class TC_zamboni_ci < Test::Unit::TestCase
   def test_one_unique
      list1 = Array.new
      list1.push ZDevice.new("Jeremy's Device", "d19e21f58096d3f81124e7200a74dbdb276c3cdc")
      list1.push ZDevice.new("Tim's Device", "c1f43d905c1e1c05badda45745d8f3438a892b93")
      list1.push ZDevice.new("John's Device", "ea9b0232a72f31efc28724580dff4c8bee")

      list2 = Array.new
      list2.push ZDevice.new("Jeremy's Device", "d19e21f58096d3f81124e7200a74dbdb276c3cdc")
      list2.push ZDevice.new("Tim's Device", "c1f43d905c1e1c05badda45745d8f3438a892b93")
      
      u_devices = DeviceParser.find_new_devices(list1, list2)

      assert(u_devices.count == 1, "should only be one device")
      assert(u_devices[0].name == "John's Device", "John's device should be unique")
      assert(u_devices[0].udid == "ea9b0232a72f31efc28724580dff4c8bee", "John's udid should be unique")
   end

   def test_one_unique_parity
      list1 = Array.new
      list1.push ZDevice.new("Jeremy's Device", "d19e21f58096d3f81124e7200a74dbdb276c3cdc")
      list1.push ZDevice.new("Tim's Device", "c1f43d905c1e1c05badda45745d8f3438a892b93")
      list1.push ZDevice.new("John's Device", "ea9b0232a72f31efc28724580dff4c8bee")

      list2 = Array.new
      list2.push ZDevice.new("Jeremy's Device", "d19e21f58096d3f81124e7200a74dbdb276c3cdc")
      list2.push ZDevice.new("Tim's Device", "c1f43d905c1e1c05badda45745d8f3438a892b93")
      
      u_devices = DeviceParser.find_new_devices(list2, list1)

      assert(u_devices.count == 0, "there shoudl be no unique devices")
   end
end
