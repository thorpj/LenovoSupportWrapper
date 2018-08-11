require './test/test_helper'

class DeviceTest < Minitest::Test
  def test_exists
    assert LenovoSupport::Device
  end

  def test_a_serial
    serial = "LR0AUZ86"
    VCR.use_cassette('one_device') do
      device = LenovoSupport::Device.find(serial)
      assert_equal LenovoSupport::Device, device.class

      assert_equal serial, device.serial
    end
  end

end