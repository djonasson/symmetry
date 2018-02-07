require 'spec_helper'

describe "Symmetry" do

  it "should define a VERSION constant" do
    expect(Symmetry).to be_const_defined(:VERSION)
  end

  context "ActiveRecord::Base" do
    it "should respond to :symmetric_relation" do
      expect(ActiveRecord::Base).to respond_to(:symmetric_relationship)
    end
    it "should not respond to :neighbors" do
      expect(ActiveRecord::Base).not_to respond_to(:neighbors)
    end
  end

  context "an instance of an ActiveRecord class calling 'symmetric_relation'" do
    let(:ts) { TestSymmetry.new }
    it "should respond to :neighbors" do
      expect(ts).to respond_to(:neighbors)
    end
    it "should respond to :neighborships" do
      expect(ts).to respond_to(:neighborships)
    end

    context "multiple symmetric relationships" do
      let(:tds) { TestDoubleSymmetry.new }
      it "should respond to :friends" do
        expect(tds).to respond_to(:friends)
      end
      it "should respond to :friend_relationships" do
        expect(tds).to respond_to :friend_relationships
      end
    end
  end

end
