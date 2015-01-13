require 'faraday'

module BasicClient
  module Middleware
    class SymbolizedJson < Faraday::Response::Middleware
      UNPARSABLE = [204, 301, 302, 304]

      def parse(body)
        case body
        when /\A^\s*$\z/, nil
          nil
        else
          try_parse(body)
        end
      end

      def on_complete(env)
        env[:body] = parse(env[:body]) unless UNPARSABLE.include?(env[:status])
      end

      def try_parse(body)
        JSON.parse(body, symbolize_names: true)
      rescue JSON::ParserError
        body
      end
    end
  end
end

Faraday::Response.register_middleware :symbolized_json => BasicClient::Middleware::SymbolizedJson
