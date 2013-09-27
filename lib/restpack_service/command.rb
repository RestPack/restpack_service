module RestPack::Service
  class Command < Mutations::Command
    attr_accessor :response

    def run
      @response = Response.new

      begin
        init
        mutation = super

        if mutation.errors
          mutation.errors.message.each do |error|
            @response.add_error(error[0], error[1].gsub(error[0].capitalize, ''))
          end

          @response.status ||= :unprocessable_entity
        else
          @response.status ||= :ok
        end

        if @response.status == :ok
          @response.result = mutation.result if mutation.result
        end
      rescue Exception => e
        puts "---COMMAND EXCEPTION---"
        puts e.message #TODO: GJ: logging
        puts e.backtrace
        puts "-----------------------"

        @response.add_error(:base, 'Service Error')
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
