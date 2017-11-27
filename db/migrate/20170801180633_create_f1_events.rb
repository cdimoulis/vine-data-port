class CreateF1Events < ActiveRecord::Migration
  def change
    create_table :f1_events do |t|
      t.string :uri
      t.string :name
      t.text :description
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end

    add_index :f1_events, :created_by_id
    add_index :f1_events, :updated_by_id
  end
end
