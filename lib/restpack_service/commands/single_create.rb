#NOTE: GJ: create commands will accept a single resource
#          until jsonapi.org a validation solution for compound documents
#          https://github.com/json-api/json-api/issues/7

module RestPack::Service
  module Commands
    class SingleCreate < RestPack::Service::Command
      def execute
        single_create!
      end
    end
  end
end
