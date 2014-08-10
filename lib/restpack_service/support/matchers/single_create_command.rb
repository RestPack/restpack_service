# def it_acts_as_single_create_command(namespace, type)
#   plural = type.to_s.pluralize.to_sym
#   namespaced_type = "#{namespace.to_s.camelize}::#{type.to_s.camelize}"
#   model_class = "Models::#{namespaced_type}".constantize
#   serializer_class = "Serializers::#{namespaced_type}".constantize

#   let(:response) { subject.class.run(params) }

#   context "with valid params" do
#     context "when creating a single item" do
#       let(:item) { build("api_#{type}".to_sym) }
#       let(:params) { item }

#       it "returns the newly created #{type}" do
#         response.success?.should == true
#         response.result[:id].should_not == nil
#         model = model_class.find(response.result[:id])
#         response.result.should == serializer_class.as_json(model)
#       end
#     end
#   end
# end
