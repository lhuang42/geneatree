class AddDirectAncestorToIndividual < ActiveRecord::Migration
  def change
    add_column :individuals, :direct, :boolean
  end
end
