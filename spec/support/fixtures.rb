module TextService
  module Models
    class Text
    end
  end

  module Serializers
    class Text
    end
  end

  module Base
    class Command < RestPack::Service::Command
    end
  end

  module Commands
    module Text
      class Reverse < Base::Command
        required do
          string :text
        end

        def execute
          text.reverse
        end
      end
    end
  end
end


module Commands
  module Math
    class Add < RestPack::Service::Command
      required do
        integer :a
        integer :b
      end

      def execute
        a + b
      end
    end
  end
end
