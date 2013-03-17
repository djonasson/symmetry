class TestSymmetry < ActiveRecord::Base
  symmetric_relation :neighbors, polymorphic_relation_name: :neighborships
end
