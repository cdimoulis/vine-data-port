class CreateF1Funds < ActiveRecord::Migration
  def change
    create_table :f1_funds do |t|
      t.string :uri
      t.integer :old_id
      t.string :name
      t.integer :fund_type_id
      t.string :fund_code
      t.boolean :is_web_enabled
      t.boolean :is_active
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end

    add_index :f1_funds, :fund_type_id
  end
end
