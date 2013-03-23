class TestSymmetry < ActiveRecord::Base
  symmetric_relationship :neighbors, polymorphic_relationship_name: :neighborships
end

class TestDoubleSymmetry < ActiveRecord::Base
  symmetric_relationship :neighbors
  symmetric_relationship :friends
end
