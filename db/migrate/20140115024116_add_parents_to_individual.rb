class AddParentsToIndividual < ActiveRecord::Migration
  def change
    change_table :individuals do |t|
      t.integer :mother_id
      t.integer :father_id
    end
  end
end
