class Individual < ActiveRecord::Base
  belongs_to :tree
  
  belongs_to :parent_a, class_name: "Individual", foreign_key: "parent_a_id"
  belongs_to :parent_b, class_name: "Individual", foreign_key: "parent_b_id"
  has_one :spouse, class_name: "Individual", foreign_key: "spouse_id"
  
  has_many :children, class_name: "Individual"
  has_many :siblings, class_name: "Individual"
  
  def children
    Individual.where("parent_a_id = ? OR parent_b_id = ?", id, id)
  end
  
  def siblings
    Individual.where("parent_a_id = ?", parent_a_id) - [Individual.find(id)]
  end
  
  def update_child_with_new_parent(parent)
    parent.generation = self.generation + 1
    if self.parent_a.nil?
      self.parent_a = parent
      parent.direct = true
      parent.save
    else
      self.parent_b = parent
      self.parent_a.spouse = parent
      parent.spouse = self.parent_a
      if parent.spouse.direct and parent.generation > 0
        parent.direct = true
      else
        parent.direct = false
      end
      parent.save
      self.parent_a.save
    end
    self.save
  end
  
  def update_new_child(child)
    child.generation = self.generation - 1
    child.parent_a = self
    child.parent_b = self.spouse if self.spouse.present?
    if child.generation < 0 and (self.direct or self.spouse.direct)
      child.direct = true
    else
      child.direct = false
    end
    child.save
  end
  
end
