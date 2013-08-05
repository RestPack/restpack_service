require 'spec_helper'

describe RestPack::Response do
  pending "Write some specs"

  describe "#from_rest" do
    it "parses a successful response" do
      response = RestPack::Response.from_rest(
        double(code: 200, body: '{ "key": "value" }')
      )

      response.status.should == :ok
      response.code.should == 200
      response.success?.should == true
      response.result.should == { key: "value" }
    end

    it "extracts errors from response body" do
      response = RestPack::Response.from_rest(
        double(code: 200, body: '{ "key": "value", "errors": {
          "name": ["error 1", "error 2"]
        } }')
      )

      response.success?.should == false
      response.result.should == { key: "value" }
      response.errors.should == { name: ["error 1", "error 2"] }
    end

  end

  describe RestPack::Response::Status do
    describe "#from_code" do
      context "valid status" do
        it "maps a code to a status" do
          RestPack::Response::Status.from_code(200).should == :ok
        end
      end

      context "invalid status" do
        it "raises an exception" do
          expect {
            RestPack::Response::Status.from_code(999)
          }.to raise_exception("Invalid Status Code: 999")
        end
      end
    end
  end
end
