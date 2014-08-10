require 'spec_helper'

describe RestPack::Command do
  context 'with a commands in a namespace like TextService::Commands::Text::Reverse' do
    it 'defines sugar methods' do
      expect(TextService::Text).to respond_to(:reverse, :reverse!)
      expect(TextService::Text.reverse!(text: 'gavin')).to eq('nivag')
    end

    it 'defines aliases' do
      Command = TextService::Commands::Text::Reverse
      command = Command.new

      expect(Command::Model).to eq(TextService::Models::Text)
      expect(command.Model).to eq(TextService::Models::Text)

      expect(Command::Serializer).to eq(TextService::Serializers::Text)
      expect(command.Serializer).to eq(TextService::Serializers::Text)

      expect(Command::Commands).to eq(TextService::Commands)
      expect(Command::Models).to eq(TextService::Models)
    end
  end

  context 'with a commands in a namespace like Commands::Template::Create' do
    it 'defines sugar methods' do
      expect(Commands::Math).to respond_to(:add, :add!)
      expect(Commands::Math.add!(a: 1, b: 2)).to eq(3)
    end
  end
end
