module RestPack::Service
  module Commands
    class Get < RestPack::Service::Command
      def execute
        result = self.class.serializer_class.resource(inputs)

        if result[self.class.serializer_class.key].empty?
          status :not_found
        else
          result
        end
      end
    end
  end
end
