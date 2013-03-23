class SymmetricRelationship < ActiveRecord::Base
  attr_accessible :owner_id, :owner_type, :relation_id, :relation_type, :relationship_name

  belongs_to :owner, polymorphic: true
  belongs_to :relation, polymorphic: true

  validates :owner_id, presence: true, uniqueness: { scope: [:owner_type, :relation_id, :relation_type, :relationship_name] }
  validates :owner_type, presence: true
  validates :relation_id, presence: true
  validates :relation_type, presence: true
  validates :relationship_name, presence: true

  after_create :create_symetric_relationship
  after_destroy :destroy_symetric_relationship

  private

  def create_symetric_relationship
    attrs = { owner_id: relation_id, owner_type: relation_type, relation_id: owner_id, relation_type: owner_type, relationship_name: relationship_name }
    self.class.create(attrs) if self.class.where(attrs).empty?
  end

  def destroy_symetric_relationship
    self.class.where(owner_id: relation_id, owner_type: relation_type, relation_id: owner_id, relation_type: owner_type, relationship_name: relationship_name).delete_all
  end
end
