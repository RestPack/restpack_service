module RestPack::Service
  module Commands
    class List < RestPack::Service::Command
      optional do
        string :include
        integer :page
        integer :page_size
      end

      def execute
        self.class.serializer_class.resource(inputs, scope)
      end

      private

      def scope
        self.class.model_class.all
      end
    end
  end
end
