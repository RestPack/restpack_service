module RestPack::Service
  module Commands
    class Create < RestPack::Service::Command
      def execute
        create!
      end
    end
  end
end
