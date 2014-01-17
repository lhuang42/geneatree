class AddNameToIndividuals < ActiveRecord::Migration
  def change
    add_column :individuals, :name, :string
  end
end
