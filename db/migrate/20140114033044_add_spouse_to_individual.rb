class AddSpouseToIndividual < ActiveRecord::Migration
  def change
    add_column :individuals, :spouse_id, :integer
  end
end
