class CreateF1SubFunds < ActiveRecord::Migration
  def change
    create_table :f1_sub_funds do |t|
      t.string :uri
      t.integer :old_id
      t.integer :fund_id
      t.string :name
      t.string :general_ledger
      t.string :sub_fund_code
      t.boolean :is_web_enabled
      t.boolean :is_active
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end

    add_index :f1_sub_funds, :fund_id
  end
end
