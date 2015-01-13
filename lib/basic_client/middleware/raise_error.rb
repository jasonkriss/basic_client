require 'faraday'

module BasicClient
  module Middleware
    class RaiseError < Faraday::Response::Middleware
      def on_complete(env)
        status = env[:status].to_i

        error_class = if status.between?(400, 499)
          BasicClient::ClientError
        elsif status.between?(500, 599)
          BasicClient::ServerError
        end

        raise error_class.new(status, env[:body]) if error_class
      end
    end
  end
end

Faraday::Response.register_middleware :raise_error => BasicClient::Middleware::RaiseError
