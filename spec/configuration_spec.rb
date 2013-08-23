require 'spec_helper'

describe RestPack::Service::Configuration do
  subject { RestPack::Service::Configuration.new }

  it "has defaults" do
    subject.db_table_prefix.should == "restpack_"
    subject.application_id.should == 1
  end

  describe ".prefix_db_table" do
    before { subject.db_table_prefix = 'prefix_' }
    it { subject.prefix_db_table('table').should == :prefix_table }
  end
end
