require 'spec_helper'

describe RestPack::Service::Configuration do
  subject { RestPack::Service::Configuration.new }

  it "has defaults" do
    subject.application_id.should == 1
  end
end
