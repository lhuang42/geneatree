class Tree < ActiveRecord::Base
  belongs_to :user
  has_many :individuals
  
  def individuals_ordered
    progen = self.individuals.min_by(&:id)
    io = []
    
    io.push(*progen.siblings) if progen.siblings.present?
    io.push(progen)
    io.push(progen.spouse) if progen.spouse.present?
    recursive_add_ancestors(progen, io)
    recursive_add_descendents(progen.children, io)
    
    spouses_arr = []
    io.each do |i|
      if i.spouse.present? and !spouses_arr.include?(i)
        spouses_arr.push(i.spouse)
      end
    end
    return io - spouses_arr
  end
  
  def recursive_add_ancestors (child, io_array)
    if child.present?
      if child.parent_a.present?
        io_array.push(*child.parent_a.siblings) if child.parent_a.siblings.present?
        io_array.push(child.parent_a)
      end
      if child.parent_b.present?
        io_array.push(child.parent_b)
        io_array.push(*child.parent_b.siblings) if child.parent_b.siblings.present?
      end
    recursive_add_ancestors(child.parent_a, io_array)
    recursive_add_ancestors(child.parent_b, io_array)
    end
  end
  
  def recursive_add_descendents (children_array, io_array)
    if !children_array.empty?
      next_gen_array = []
      children_array.each do |c|
        io_array.push(c)
        io_array.push(c.spouse) if c.spouse.present?
        next_gen_array.push(*c.children)
      end
      recursive_add_descendents(next_gen_array, io_array)
    end
  end  

end
