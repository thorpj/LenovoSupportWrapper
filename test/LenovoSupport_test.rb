require "test_helper"
require 'byebug'


class LenovoSupportTest < Minitest::Test
  include ::LenovoSupport

  def test_that_it_has_a_version_number
    refute_nil ::LenovoSupport::VERSION
  end

  def test_it_does_something_useful
    assert false
  end

  def test_get_parts
    serial = 'LR04MPAY'
    parser = ::LenovoSupport::ProductPartsParser.new(serial)
    byebug
  end
end
