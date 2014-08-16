module RestPack::Service
  module Commands
    class List < RestPack::Service::Command
      optional do
        string :include
        integer :page
        integer :page_size
      end

      def execute
        Serializer.resource(inputs)
      end
    end
  end
end
