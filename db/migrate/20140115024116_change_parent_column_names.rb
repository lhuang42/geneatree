class ChangeParentColumnNames < ActiveRecord::Migration
  def change
    change_table :individuals do |t|
      t.rename :mother_id, :parent_a_id
      t.rename :father_id, :parent_b_id
    end
  end
end
