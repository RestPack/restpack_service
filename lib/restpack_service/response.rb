module RestPack
  class Response
    attr_accessor :result, :errors, :status

    def initialize
      @errors = []
    end

    def success?
      @errors.empty? and @status == :success
    end

    def field_errors(key)
      @errors.select { |error| error.key.to_sym == key.to_sym }
    end
  end
end
