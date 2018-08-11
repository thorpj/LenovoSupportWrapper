module LenovoSupport
    class Config
      require 'yaml'

      attr_accessor :config
      def initialize
        @config = YAML::load_file('../config/config.yaml')
      end

      def [](v)
        @config[v]
      end
      def []=(k,v)
        @config[k] = v
      end

      public

      def access_token(val)
        @config[:access_token] = val
      end


    end
  end