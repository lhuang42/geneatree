class AddOldestGenToTree < ActiveRecord::Migration
  def change
    add_column :trees, :oldest_gen, :integer
  end
end
