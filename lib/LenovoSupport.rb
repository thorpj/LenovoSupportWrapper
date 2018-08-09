require "LenovoSupport/version"

module LenovoSupport
  require 'active_support'
  require 'active_attr'
  require 'LenovoSupport/config'
  require 'LenovoSupport/base'
  require 'LenovoSupport/exceptions'
  require 'LenovoSupport/device'


  mattr_accessor :configuration
  self.configuration ||= LenovoSupport::Config.new
  def LenovoSupport.config
    yield self.configuration if block_given?
    self.configuration.config
  end

end
