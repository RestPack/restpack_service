module RestPack::Service
  module Commands
    class Create < RestPack::Service::Command

      def execute
        models = self.class.model_class.create!(inputs[self.class.serializer_class.key])
        self.class.serializer_class.serialize models
      end
    end
  end
end
