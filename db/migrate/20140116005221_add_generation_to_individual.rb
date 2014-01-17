class AddGenerationToIndividual < ActiveRecord::Migration
  def change
    add_column :individuals, :generation, :integer
    add_column :individuals, :blood, :boolean
  end
end
