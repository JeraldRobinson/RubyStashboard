class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :name
      t.string :description
      t.string :level
      t.string :image

      t.timestamps
    end
    
  end
end
