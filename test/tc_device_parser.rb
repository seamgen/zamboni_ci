require 'test/unit'
require '../lib/zamboni_ci/device_parser'

class TC_device_parser < Test::Unit::TestCase
   def test_empty_string
      devices = DeviceParser.parse_hockey("")
      assert(devices.count == 0, "device array should be empty")
   end

   def test_with_header
      input = "Device ID   Device Name
      d19e21f58096d3f81124e7200a74dbdb276c3cdc  Jeremy Moyers iPhone 5s
      ea9b0232a72f31efc28724580dff4c8beec98361  Some unknown
      c1f43d905c1e1c05badda45745d8f3438a892b93  Some unknown"
      devices = DeviceParser.parse_hockey(input)
      
      assert(devices.count == 3, "devices should have three elements")
      assert(devices[0].udid == "d19e21f58096d3f81124e7200a74dbdb276c3cdc", "device one")
      assert(devices[0].name == "Jeremy Moyers iPhone 5s")
      assert(devices[1].udid == "ea9b0232a72f31efc28724580dff4c8beec98361", "device two")
      assert(devices[1].name == "Some unknown")
      assert(devices[2].udid == "c1f43d905c1e1c05badda45745d8f3438a892b93", "device three")
      assert(devices[2].name == "Some unknown")
   end

   def test_no_header
      input = "d19e21f58096d3f81124e7200a74dbdb276c3cdc  Jeremy Moyers iPhone 5s
      ea9b0232a72f31efc28724580dff4c8beec98361  Some unknown
      c1f43d905c1e1c05badda45745d8f3438a892b93  Some unknown"
      devices = DeviceParser.parse_hockey(input)

      assert(devices.count == 3, "devices should have three elements")
      assert(devices[0].udid == "d19e21f58096d3f81124e7200a74dbdb276c3cdc", "device one")
      assert(devices[0].name == "Jeremy Moyers iPhone 5s")
      assert(devices[1].udid == "ea9b0232a72f31efc28724580dff4c8beec98361", "device two")
      assert(devices[1].name == "Some unknown")
      assert(devices[2].udid == "c1f43d905c1e1c05badda45745d8f3438a892b93", "device three")
      assert(devices[2].name == "Some unknown")
   end

   def test_only_header
      input = "Device ID   Device Name"
      devices = DeviceParser.parse_hockey(input)
      assert(devices.count == 0, "device array should be empty")
   end

   def test_device_no_name
      input = "Device ID   Device Name
      d19e21f58096d3f81124e7200a74dbdb276c3cdc"
      devices = DeviceParser.parse_hockey(input)
      assert(devices.count == 1, "devices should have three elements")
      assert(devices[0].udid == "d19e21f58096d3f81124e7200a74dbdb276c3cdc", "")
   end
end
