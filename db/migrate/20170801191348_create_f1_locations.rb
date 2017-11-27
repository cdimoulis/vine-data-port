class CreateF1Locations < ActiveRecord::Migration
  def change
    create_table :f1_locations do |t|
      t.string :uri
      t.string :name
      t.string :description
      t.integer :event_id
      t.boolean :is_online
      t.string :url
      t.json :address
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps null: false
    end

    add_index :f1_locations, :event_id
  end
end
