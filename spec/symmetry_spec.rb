require 'spec_helper'

describe "Symmetry" do

  context "ActiveRecord::Base" do
    it "should respond to :symmetric_relation" do
      ActiveRecord::Base.should respond_to :symmetric_relation
    end
    it "should not respond to :neighbors" do
      ActiveRecord::Base.should_not respond_to :neighbors
    end
  end

  context "an instance of an ActiveRecord class calling 'symmetric_relation :neigbors'" do
    let(:ts) { TestSymmetry.new }
    it "should respond to :neighbors" do
      ts.should respond_to :neighbors
    end
    it "should respond to :neighborships" do
      ts.should respond_to :neighborships
    end
  end

end
