class AddTreesToUsers < ActiveRecord::Migration
  def change
    add_column :trees, :user_id, :integer
  end
end
