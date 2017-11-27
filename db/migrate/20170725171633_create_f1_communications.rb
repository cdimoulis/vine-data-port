class CreateF1Communications < ActiveRecord::Migration
  def change
    create_table :f1_communications do |t|
      t.string :uri
      t.integer :household_id
      t.integer :person_id
      t.integer :communication_type_id
      t.string :communication_general_type
      t.string :communication_value
      t.string :search_communication_value
      t.boolean :preferred
      t.text :communication_comment

      t.timestamps null: false
    end

    add_index :f1_communications, :household_id
    add_index :f1_communications, :person_id
    add_index :f1_communications, :communication_type_id
  end
end
