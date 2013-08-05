module RestPack
  class Response
    attr_accessor :result, :errors, :status

    def initialize
      @result = {}
      @errors = {}
    end

    def success?
      @errors.empty? and @status == :ok
    end

    def code
      Status.from_status(status)
    end

    def add_error(field, message)
      @errors[field] ||= []
      @errors[field] << message
    end

    def self.from_rest(rest_response)
      response = new
      response.status = Status.from_code(rest_response.code)
      response.result = Yajl::Parser.parse(rest_response.body, :symbolize_keys => true)

      if response.result[:errors]
        response.result[:errors].each do |field, errors|
          response.errors[field.to_sym] = errors
        end

        response.result.delete :errors
      end

      response
    end

    class Status
      @@map = {
        200 => :ok,
        404 => :not_found,
        422 => :unprocessable_entity,
        500 => :internal_service_error
      }

      def self.from_code(code)
        if @@map.has_key?(code)
          @@map[code]
        else
          raise "Invalid Status Code: #{code}"
        end
      end

      def self.from_status(status)
        if @@map.has_value?(status)
          @@map.key(status)
        else
          raise "Invalid Status: #{status}"
        end
      end
    end
  end
end
