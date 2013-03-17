require 'spec_helper'

describe SymmetricRelationship do
  it { should validate_presence_of :owner_id }
  it { should validate_presence_of :owner_type }
  it { should validate_presence_of :relation_id }
  it { should validate_presence_of :relation_type }

  it { should validate_uniqueness_of(:owner_id).scoped_to(:owner_type, :relation_id, :relation_type) }

  context "an instance of an ActiveRecord class calling symmetric_relation :neighbors" do
    let(:ts) { TestSymmetry.new }
    let(:ts2) { TestSymmetry.new }
    let(:ts3) { TestSymmetry.new }
    it "should respond to :neighbors" do
      ts.should respond_to :neighbors
    end
    it "should not have any neighbors before any have been added" do
      ts.neighbors.should be_empty
    end
    it "should have a neighbor after one has been added" do
      ts.neighbors << ts2
      ts.neighbors.should_not be_empty
    end
    it "should have two neighbors after two have been added" do
      ts.save
      ts.neighbors << [ts2, ts3]
      ts.neighbors.count.should == 2
    end
    it "should have a symetric neighbors association" do
      [ts, ts2, ts3].map(&:save)
      ts.neighbors << [ts2, ts3]
      ts2.neighbors.should include(ts)
      ts3.neighbors.should include(ts)
    end
    it "should ensure the destruction of symetric neighbors association when one neighbor is deleted" do
      [ts, ts2, ts3].map(&:save)
      ts.neighbors << ts2
      ts2.neighbors << ts3
      ts2.destroy
      [ts, ts3].map(&:reload)
      ts.neighbors.should_not include(ts2)
      ts3.neighbors.should_not include(ts2)
    end
    it "'create_symetric_relation' should be called after create" do
      ts.save
      ts.neighborships.any_instance.should_receive(:create_symetric_relation)
      ts.neighbors << ts2
    end
    it "'destroy_symetric_relation' should be called after destroy" do
      ts.save
      ts.neighbors << ts2
      ts.neighborships.any_instance.should_receive(:destroy_symetric_relation)
      ts.destroy
    end
  end

end
