class CreateF1Requirements < ActiveRecord::Migration
  def change
    create_table :f1_requirements do |t|
      t.string :uri
      t.string :old_id
      t.string :name
      t.boolean :is_active
      t.boolean :has_document
      t.boolean :is_confidential
      t.boolean :is_background_check
      t.boolean :is_reference_check
      t.integer :quantity

      t.timestamps null: false
    end

    add_index :f1_requirements, :name
  end
end
