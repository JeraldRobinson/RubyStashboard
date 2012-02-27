class AddColumnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :status_id, :integer
    add_index :events, [:status_id, :created_at]
  end
end
