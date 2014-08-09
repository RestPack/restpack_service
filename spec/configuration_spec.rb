require 'spec_helper'

describe RestPack::Service::Configuration do
  subject { RestPack::Service::Configuration.new }

  it 'has defaults' do
    expect(subject.application_id).to eq(1)
  end
end
