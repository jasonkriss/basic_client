module BasicClient
  class Error < StandardError
    attr_reader :status

    def initialize(status, message)
      @status = status
      super(message)
    end
  end

  ServerError = Class.new(Error)
  ClientError = Class.new(Error)
end
