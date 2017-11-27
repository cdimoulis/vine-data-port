class CreateF1Attributes < ActiveRecord::Migration
  def change
    create_table :f1_attributes do |t|
      # t.integer :f1_id, null: false, unique: true
      t.string :uri
      t.integer :old_id
      t.string :name
      t.integer :attribute_group_id

      # t.timestamps null: false
    end

    add_index :f1_attributes, :attribute_group_id
    add_index :f1_attributes, :name
  end
end
