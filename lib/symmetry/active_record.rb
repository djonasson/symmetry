module Symmetry
  module ActiveRecord

    def symmetric_relationship(relationship_name, options = {})
      options.assert_valid_keys(:polymorphic_relationship_name)

      relationship_name_singular = relationship_name.to_s.singularize
      polymorphic_relationship_name = (options[:polymorphic_relationship_name].presence || "#{relationship_name_singular}_relationships").to_sym

      has_many polymorphic_relationship_name, -> { where(relationship_name: relationship_name ) }, class_name: "SymmetricRelationship", as: :owner, dependent: :destroy
      has_many relationship_name, through: polymorphic_relationship_name, as: :relation, source: :relation, source_type: self.name
    end

  end
end
