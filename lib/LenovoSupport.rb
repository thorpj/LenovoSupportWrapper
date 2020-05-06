require_relative 'LenovoSupport/version'

module LenovoSupport
  # require 'active_support'
  # require 'active_attr'

  require_relative 'LenovoSupport/config'
  require_relative 'LenovoSupport/base'

  require_relative 'LenovoSupport/exceptions'
  require_relative 'LenovoSupport/device'

  require_relative 'LenovoSupport/parsers/Content'
  require_relative 'LenovoSupport/parsers/Part'
  require_relative 'LenovoSupport/parsers/Product'



  def LenovoSupport.config
    yield self.configuration if block_given?
    self.configuration.config
  end
  def self.configuration
    @configuration
  end
  def self.configuration=(value)
    @configuration = value
  end

  self.configuration ||= LenovoSupport::Config.new


  begin
    require File.expand_path('../config/secrets.rb', File.dirname(__FILE__))
  rescue LoadError
    puts "Failed to load secrets.rb"
  end

  def LenovoSupport::Setup(token)
    self.config[:access_token] = token
  end
end
