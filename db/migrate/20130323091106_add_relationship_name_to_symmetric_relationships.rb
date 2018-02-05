class AddRelationshipNameToSymmetricRelationships < ActiveRecord::Migration[5.0]
  def change
    add_column :symmetric_relationships, :relationship_name, :string
  end
end
