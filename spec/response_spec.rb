require 'spec_helper'

describe RestPack::Service::Response do
  describe '#from_rest' do
    it 'parses a successful response' do
      response = RestPack::Service::Response.from_rest(
        double(code: 200, body: '{ "key": "value" }')
      )

      expect(response.status).to eq(:ok)
      expect(response.code).to eq(200)
      expect(response.success?).to eq(true)
      expect(response.result).to eq({ key: "value" })
    end

    it "extracts errors from response body" do
      response = RestPack::Service::Response.from_rest(
        double(code: 200, body: '{ "key": "value", "errors": {
          "name": ["error 1", "error 2"]
        } }')
      )

      expect(response.success?).to eq(false)
      expect(response.result).to eq({ key: "value" })
      expect(response.errors).to eq({ name: ["error 1", "error 2"] })
    end

  end

  describe RestPack::Service::Response::Status do
    describe '#from_code' do
      context 'valid status' do
        it 'maps a code to a status' do
          expect(RestPack::Service::Response::Status.from_code(200)).to eq(:ok)
        end
      end

      context 'invalid status' do
        it 'raises an exception' do
          expect {
            RestPack::Service::Response::Status.from_code(999)
          }.to raise_exception('Invalid Status Code: 999')
        end
      end
    end
  end
end
