class AddIndividualsToTree < ActiveRecord::Migration
  def change
    add_column :individuals, :tree_id, :integer
  end
end
