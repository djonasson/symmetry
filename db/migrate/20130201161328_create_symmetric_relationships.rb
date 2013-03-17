class CreateSymmetricRelationships < ActiveRecord::Migration
  def change
    create_table :symmetric_relationships do |t|
      t.integer :owner_id
      t.string  :owner_type
      t.integer :relation_id
      t.string  :relation_type
      t.timestamps
    end
  end
end
