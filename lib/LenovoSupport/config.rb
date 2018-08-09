module LenovoSupport
    class Config
      require 'yaml'

      attr_accessor :config
      def initialize
        @config = YAML::load_file('config/config.yaml')
      end

      def [](v)
        @config[v]
      end
      def []=(k,v)
        @config[k] = v
      end

      public

      def api_token(val)
        @config[:api_token] = val
      end


    end
  end