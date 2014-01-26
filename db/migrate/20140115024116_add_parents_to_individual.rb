class AddParentsToIndividual < ActiveRecord::Migration
  def change
    change_table :individuals do |t|
      t.integer :parent_a_id
      t.integer :parent_b_id
    end
  end
end
