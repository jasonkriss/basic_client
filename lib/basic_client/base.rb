require 'faraday'
require 'faraday_middleware'

module BasicClient
  class Base
    class << self
      attr_accessor :base_url

      def with_base(url)
        @base_url = url
      end
    end

    def get(path, params = {}, headers = {}, &block)
      request(:get, path, params, headers, &block)
    end

    def post(path, params = {}, headers = {}, &block)
      request(:post, path, params, headers, &block)
    end

    def put(path, params = {}, headers = {}, &block)
      request(:put, path, params, headers, &block)
    end

    def delete(path, params = {}, headers = {}, &block)
      request(:delete, path, params, headers, &block)
    end

    private
    def request(method, path, params, headers, &block)
      response = connection.send(method, path, params, headers, &block)
      response.body
    end

    def connection
      @connection ||= build_connection
    end

    def build_connection
      Faraday.new(self.class.base_url) do |connection|
        connection.path_prefix = path_prefix if path_prefix
        set_request_middleware(connection)
        set_response_middleware(connection)
        connection.adapter :net_http
      end
    end

    def path_prefix; end

    def set_request_middleware(connection)
      connection.request :json
    end

    def set_response_middleware(connection)
      connection.response :symbolized_json
      connection.response :raise_error
    end
  end
end
