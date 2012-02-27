class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.references :user
      t.string :name
      t.string :description
      t.string :url

      t.timestamps
    end
    add_index :services, :user_id
  end
end
