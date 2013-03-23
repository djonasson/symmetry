class AddRelationshipNameToSymmetricRelationships < ActiveRecord::Migration
  def change
    add_column :symmetric_relationships, :relationship_name, :string
  end
end
