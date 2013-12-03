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

    def get
      identifier = service_identifiers[:resources]
      result = serializer_klass.resource(inputs)

      if result[identifier].empty?
        status :not_found
      else
        result
      end
    end

    def list
      serializer_klass.resource(inputs)
    end

    def create!
      identifier = service_identifiers[:resources]
      models = create_models!(inputs[identifier])
      serialize(models)
    end

    def single_create!
      identifier = service_identifiers[:resources]
      model = model_klass.create!(inputs)
      as_json(model)
    end

    def serialize(models)
      serializer_klass.serialize(models)
    end

    def as_json(model)
      serializer_klass.as_json(model)
    end

    private

    def create_models!(array)
      model_klass.create!(array)
    end

    def serializer_klass
      "Serializers::#{service_namespace}".constantize
    end

    def model_klass
      "Models::#{service_namespace}".constantize
    end

    def service_namespace
      identifiers = service_identifiers
      namespace = "#{identifiers[:service]}::#{identifiers[:resource].capitalize}"
    end

    def service_identifiers
      #extract identifiers from ancestor in the form of 'Commands::Core::Application::Get'
      namespaces = self.class.ancestors.first.to_s.split('::')
      resource = namespaces[2].downcase
      return {
        service: namespaces[1].to_sym,
        resource: resource.to_sym,
        resources: resource.pluralize.to_sym
      }
    end
  end
end
