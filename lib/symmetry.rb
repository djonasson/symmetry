require "symmetry/engine"
require "symmetry/active_record"

module Symmetry
end

ActiveRecord::Base.extend(Symmetry::ActiveRecord)
