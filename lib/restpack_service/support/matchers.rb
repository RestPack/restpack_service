def is_required(*params)
  params.each do |param|
    it ":#{param} parameter must be required" do
      expect(subject.class.input_filters.required_inputs).to include(param)
    end
  end
end

def is_optional(*params)
  params.each do |param|
    it ":#{param} parameter must be required" do
      expect(subject.class.input_filters.optional_inputs).to include(param)
    end
  end
end

def service_request_with(param, value, &block)
  context "when :#{param} = #{value.inspect}" do
    let(:params) do
      super().merge({ param => value })
    end
    it { yield(response.result) }
  end
end

def service_should_map(param, map)
  context param do
    map.each do |value, expected|
      service_request_with(param, value) { |r| r[param].should == expected }
    end
  end
end

def it_acts_as_create_command(type)
  plural = "#{type}s".to_sym
  model_class = "Models::#{type.capitalize}".constantize
  serializer_class = "Serializers::#{type.capitalize}".constantize

  let(:response) { subject.class.run(params) }

  context "with valid params" do
    context "when creating a single item" do
      let(:item) { build("#{type}_request".to_sym) }
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
      let(:item1) { build("#{type}_request".to_sym) }
      let(:item2) { build("#{type}_request".to_sym) }
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
