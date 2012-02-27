class AddUserIdIndexToServices < ActiveRecord::Migration
  def change
    add_index :services, [:user_id, :created_at]
  end
end