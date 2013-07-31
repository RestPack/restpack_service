module RestPack
  class Service < Mutations::Command
    attr_accessor :response

    def run
      @response = Response.new

      begin
        init
        mutation = super

        if mutation.errors
          mutation.errors.message.each do |error|
            @response.errors << Error.new(error[0], error[1].gsub(error[0].capitalize, ''))
          end

          @response.status ||= :unprocessable_entity
        else
          @response.status ||= :success
        end

        if @response.status == :success
          @response.result = mutation.result
        end
      rescue
        @response.errors << Error.new(:base, 'Service Error')
        @response.status = :internal_service_error
      end

      @response
    end

    def init
    end

    def status(status)
      @response.status = status
    end

    def valid?
      !has_errors?
    end

    def service_error(message)
      field_error :base, message
    end

    def field_error(key, message)
      add_error key, key, message
    end
  end
end
