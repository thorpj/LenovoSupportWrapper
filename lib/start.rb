#require_relative 'LenovoSupport'
#product = LenovoSupport::ProductParser.new "LR04MPAY"
#contents = LenovoSupport::ContentParser.new "LR04MPAY"
#
# require 'pp'
# require_relative 'LenovoSupport'
# # content = LenovoSupport::ContentParser.new "LR04MPAY"
# # #manuals = content.manuals
# # drivers = content.drivers
# require 'awesome_print'
#
# require_relative 'LenovoSupport'
# dev = LenovoSupport::Device.new "LR04MPAY"
# pp dev.drivers.last
#
# puts "\n\n\n"
#
#
# pp dev.drivers.last.files

require_relative 'LenovoSupport';  dev = LenovoSupport::Device.new "LR04MPAY"
puts dev.inspect