class CreateF1AttributeGroups < ActiveRecord::Migration
  def change
    create_table :f1_attribute_groups do |t|
      # t.integer :f1_id, null: false, unique: true
      t.string :uri
      t.integer :old_id
      t.string :name

      # t.timestamps null: false
    end

    add_index :f1_attribute_groups, :name
  end
end
