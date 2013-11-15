def it_acts_as_create_command(namespace, type)
  plural = type.to_s.pluralize.to_sym
  namespaced_type = "#{namespace.to_s.camelize}::#{type.to_s.camelize}"
  model_class = "Models::#{namespaced_type}".constantize
  serializer_class = "Serializers::#{namespaced_type}".constantize

  let(:response) { subject.class.run(params) }

  context "with valid params" do
    context "when creating a single item" do
      let(:item) { build("api_#{type}".to_sym) }
      let(:params) { { plural => [item] } }

      it "returns the newly created #{type}" do
        response.success?.should == true
        response.result.should include(plural), "The reponse should include :#{plural} array"

        response_items = response.result[plural]
        response_items.length.should == 1
        response_item = response_items.first

        model = model_class.find(response_item[:id])
        response_item.should == serializer_class.as_json(model)
      end
    end

    context "when creating multiple items" do
      let(:item1) { build("api_#{type}".to_sym) }
      let(:item2) { build("api_#{type}".to_sym) }
      let(:params) { { plural => [item1, item2] } }

      it "returns the newly created #{type}s" do
        response.success?.should == true
        response.result.should include(plural), "The reponse should include :#{plural} array"

        response_items = response.result[plural]
        response_items.length.should == 2
      end
    end
  end
end
