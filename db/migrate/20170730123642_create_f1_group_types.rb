class CreateF1GroupTypes < ActiveRecord::Migration
  def change
    create_table :f1_group_types do |t|
      t.string :name
      t.string :uri
      t.string :description
      t.boolean :is_web_enabled
      t.boolean :is_searchable
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps null: false
    end

    add_index :f1_group_types, :name
  end
end
