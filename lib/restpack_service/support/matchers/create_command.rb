def it_acts_as_create_command
  let(:response) { subject.class.run(params) }
  let(:resource_plural) { subject.Serializer.plural_key }
  let(:resource_singular) { subject.Serializer.singular_key }

  context "with valid params" do
    context "when creating a single item" do
      let(:item) { build("api_#{resource_singular}") }
      let(:params) { { resource_plural => [item] } }

      it_succeeds "and returns the newly created resource" do
        expect(response.result).to include(resource_plural), "The reponse should include an array of :#{resource_plural}"

        response_items = response.result[resource_plural]
        expect(response_items.length).to eq(1)

        response_item = response_items.first
        model = subject.Model.find(response_item[:id])
        expect(response_item).to eq(subject.Serializer.as_json(model))
      end
    end
  end

  context "when creating multiple items" do
    let(:item1) { build("api_#{resource_singular}".to_sym) }
    let(:item2) { build("api_#{resource_singular}".to_sym) }
    let(:params) { { resource_plural => [item1, item2] } }

    it_succeeds "and returns the newly created resources" do
      expect(response.result).to include(resource_plural), "The reponse should include an array of :#{resource_plural}"

      response_items = response.result[resource_plural]
      expect(response_items.length).to eq(2)

      response_items.each do |response_item|
        model = subject.Model.find(response_item[:id])
        expect(response_item).to eq(subject.Serializer.as_json(model))
      end
    end
  end
end
