module RestPack::Service
  module Commands
    class Update < RestPack::Service::Command

      def execute
        key = self.class.serializer_class.key
        result = { key => [] }

        self.class.model_class.transaction do
          inputs[key].each do |model_inputs|
            model = find_model(model_inputs)

            if model
              model = update_model(model, model_inputs)
              result[key] << self.class.serializer_class.as_json(model)
            else
              status :not_found
            end
          end
        end

        result
      end

      private

      def find_model(model_inputs)
        self.class.model_class.find(model_inputs[:id])
      end

      def update_model(model, model_inputs)
        model.update_attributes(model_inputs)
        model
      end
    end
  end
end
