#require_relative 'LenovoSupport'
#product = LenovoSupport::ProductParser.new "LR04MPAY"
#contents = LenovoSupport::ContentParser.new "LR04MPAY"

require 'pp'
require_relative 'LenovoSupport'
# content = LenovoSupport::ContentParser.new "LR04MPAY"
# #manuals = content.manuals
# drivers = content.drivers
product_parts_parser = LenovoSupport::ProductPartsParser.new "LR04MPAY"
pp product_parts_parser.parts