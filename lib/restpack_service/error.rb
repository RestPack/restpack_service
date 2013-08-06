module RestPack::Service
  class Error
    attr_accessor :key, :message

    def initialize(key, message)
      @key = key
      @message = message
    end
  end
end
