require_relative 'LenovoSupport'
p = LenovoSupport::ProductParser.new "LR04MPAY"
puts p.data
