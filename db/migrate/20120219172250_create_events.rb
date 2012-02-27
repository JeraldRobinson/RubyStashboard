class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :message
      t.integer :service_id

      t.timestamps
    end
    
    add_index :events, [:service_id, :created_at]
    
  end
end
