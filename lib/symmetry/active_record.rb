module Symmetry
  module ActiveRecord

    def symmetric_relation(relation_name, options = {})
      options.assert_valid_keys(:polymorphic_relation_name)

      relation_name_singular = relation_name.to_s.singularize
      polymorphic_relation_name = options[:polymorphic_relation_name].presence || "#{relation_name_singular}_relations"

      attr_accessible "#{relation_name_singular}_ids"
      has_many polymorphic_relation_name, class_name: "SymmetricRelationship", as: :owner, dependent: :destroy
      has_many relation_name, through: polymorphic_relation_name, as: :relation, source: :relation, source_type: self.name
    end

  end
end
