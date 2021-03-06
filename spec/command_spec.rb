require 'spec_helper'

describe RestPack::Service::Command do
  context 'with a commands in a namespace like TextService::Commands::Text::Reverse' do
    it 'defines aliases' do
      Command = TextService::Commands::Text::Reverse
      command = Command.new

      expect(command.Model).to eq(TextService::Models::Text)
      expect(Command::Model).to eq(TextService::Models::Text)
      expect(Command.model_class).to eq(TextService::Models::Text)

      expect(command.Serializer).to eq(TextService::Serializers::Text)
      expect(Command::Serializer).to eq(TextService::Serializers::Text)
      expect(Command.serializer_class).to eq(TextService::Serializers::Text)

      expect(Command::Commands).to eq(TextService::Commands)
      expect(Command::Models).to eq(TextService::Models)
    end
  end
end
