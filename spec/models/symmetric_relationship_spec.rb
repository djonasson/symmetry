require 'spec_helper'

describe SymmetricRelationship, type: :model do
  it { should validate_presence_of(:owner_id) }
  it { should validate_presence_of(:owner_type) }
  it { should validate_presence_of(:relation_id) }
  it { should validate_presence_of(:relation_type) }

  it { should validate_uniqueness_of(:owner_id).scoped_to(:owner_type, :relation_id, :relation_type, :relationship_name) }

  context "an instance of an ActiveRecord class calling symmetric_relation :neighbors" do
    let(:ts) { TestSymmetry.create }
    let(:ts2) { TestSymmetry.create }
    let(:ts3) { TestSymmetry.create }
    it "should respond to :neighbors" do
      expect(ts).to respond_to(:neighbors)
    end
    it "should respond to :neighborships" do
      expect(ts).to respond_to(:neighborships)
    end
    it "should not have any neighbors before any have been added" do
      expect(ts.neighbors).to be_empty
    end
    it "should have a neighbor after one has been added" do
      ts.neighbors << ts2
      expect(ts.neighbors).not_to be_empty
    end
    it "should have two neighbors after two have been added" do
      ts.neighbors << [ts2, ts3]
      ts.save!
      ts.reload
      expect(ts.neighbors.count).to eq(2)
    end
    it "should have a symetric neighbors association" do
      ts.neighbors << [ts2, ts3]
      expect(ts2.neighbors).to include(ts)
      expect(ts3.neighbors).to include(ts)
    end
    it "should ensure the destruction of symetric neighbors association when one neighbor is deleted" do
      ts.neighbors << ts2
      ts2.neighbors << ts3
      ts2.destroy
      [ts, ts3].map(&:reload)
      expect(ts.neighbors).not_to include(ts2)
      expect(ts3.neighbors).not_to include(ts2)
    end
    it "'create_symetric_relationship' should be called after create" do
      ts.neighborships.any_instance.should_receive(:create_symetric_relationship)
      ts.neighbors << ts2
    end
    it "'destroy_symetric_relationship' should be called after destroy" do
      ts.neighbors << ts2
      ts.neighborships.any_instance.should_receive(:destroy_symetric_relationship)
      ts.destroy
    end
    #it "should be possible to create a new record by passing a hash" do
    #  test = TestSymmetry.new({ "neighbor_ids"=>[ts2.id.to_s] })
    #  test.save!
    #  test.reload
    #  expect(test.neighbors).to include(ts2)
    #end
  end

  context "an instance of an ActiveRecord class calling both 'symmetric_relation :neighbors' and 'symmetric_relation :friends'" do
    let(:tds) { TestDoubleSymmetry.create }
    let(:tds2) { TestDoubleSymmetry.create }
    let(:tds3) { TestDoubleSymmetry.create }
    it "should not have any neighbors or friends before any have been added" do
      expect(tds.neighbors).to be_empty
      expect(tds.friends).to be_empty
    end
    it "should have one neighbor and one friend after one of each has been added" do
      tds.neighbors << tds2
      tds.friends << tds3
      tds.save!
      tds.reload
      expect(tds.neighbors.count).to eq(1)
      expect(tds.friends.count).to eq(1)
    end
    it "should create a SymmetricRelationship record with the correct 'relationship_name' set" do
      tds.neighbors << tds2
      expect(SymmetricRelationship.last.relationship_name).to eq('neighbors')
      tds.friends << tds3
      expect(SymmetricRelationship.last.relationship_name).to eq('friends')
    end
    it "should find SymmetricRelationship records from the 'relationship_name'" do
      tds.neighbors << tds2
      tds.friends << tds3
      expect(SymmetricRelationship.where(relationship_name: 'neighbors').count).to eq(2)
      expect(SymmetricRelationship.where(relationship_name: 'friends').count).to eq(2)
    end
  end

end
