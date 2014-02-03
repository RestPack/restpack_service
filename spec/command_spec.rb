require 'spec_helper'

describe RestPack::Command do
  context 'with a commands in a namespace like TextService::Commands::Text::Reverse' do
    it 'defines sugar methods' do
      TextService::Text.respond_to?(:reverse).should == true
      TextService::Text.respond_to?(:reverse!).should == true
      TextService::Text.reverse!(text: 'gavin').should == 'nivag'
    end

    it 'defines aliases' do
      command = TextService::Commands::Text::Reverse

      command::Model.should == TextService::Models::Text
      command::Serializer.should == TextService::Serializers::Text
      command::Commands.should == TextService::Commands
      command::Models.should == TextService::Models
    end
  end

  context 'with a commands in a namespace like Commands::Template::Create' do
    it 'defines sugar methods' do
      Commands::Math.respond_to?(:add).should == true
      Commands::Math.respond_to?(:add!).should == true
      Commands::Math.add!(a: 1, b: 2).should == 3
    end
  end
end
