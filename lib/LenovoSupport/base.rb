module LenovoSupport
  require 'httparty'

  class Base
    include HTTParty
    # debug_output $stdout


    base_uri "http://supportapi.lenovo.com/v2.5"

    def self.get_request(path, params={})
      dispatch_query(:get, "/#{path}", headers: authentication_header,
                     query: params)
    end

    def self.post_request(path, params={})
      dispatch_query(:post, "/#{path}", headers: authentication_header,
                     body: params.to_json)
    end


    def self.put_request(path, params)
      dispatch_query(:put, "/#{path}", headers: authentication_header,
                     body: params.to_json)
    end

    def self.patch_request(path, params)
      dispatch_query(:patch, "/#{path}", headers: authentication_header,
                     body: params.to_json)
    end

    def self.delete_request(path)
      dispatch_query(:delete, "/#{path}", headers: authentication_header)
    end


    def self.dispatch_query(method, path, payload)
      api_response = send(method, path, payload)

      raise LenovoSupport::APIError.new('Unable to parse response') unless api_response.parsed_response
      response = api_response.parsed_response

      if response == Hash && response['errors']
        raise LenovoSupport::ArgumentError response['errors']
      end

      response
    end

    def self.access_token
      if LenovoSupport::config.nil? || LenovoSupport::config[:access_token].nil?
        raise Exception
      end
      LenovoSupport::config[:access_token]
    end

    def self.authentication_header
      { 'ClientID' => access_token }
    end

    private_class_method :authentication_header
    private_class_method :access_token
  end
end