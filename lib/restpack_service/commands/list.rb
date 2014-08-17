module RestPack::Service
  module Commands
    class List < RestPack::Service::Command
      optional do
        string :include
        integer :page
        integer :page_size
      end

      def execute
        self.class.serializer_class.resource(inputs)
      end
    end
  end
end
