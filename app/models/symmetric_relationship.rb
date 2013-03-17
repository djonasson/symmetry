class SymmetricRelationship < ActiveRecord::Base
  attr_accessible :owner_id, :owner_type, :relation_id, :relation_type

  belongs_to :owner, polymorphic: true
  belongs_to :relation, polymorphic: true

  validates :owner_id, presence: true, uniqueness: { scope: [:owner_type, :relation_id, :relation_type] }
  validates :owner_type, presence: true
  validates :relation_id, presence: true
  validates :relation_type, presence: true

  after_create :create_symetric_relation
  after_destroy :destroy_symetric_relation

  private

  def create_symetric_relation
    if self.class.where(owner_id: relation_id, owner_type: relation_type, relation_id: owner_id, relation_type: owner_type).empty?
      self.class.create(owner_id: relation_id, owner_type: relation_type, relation_id: owner_id, relation_type: owner_type)
    end
  end

  def destroy_symetric_relation
    self.class.where(owner_id: relation_id, owner_type: relation_type, relation_id: owner_id, relation_type: owner_type).each do |record|
      record.delete
    end
  end
end
