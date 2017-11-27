class CreateF1Households < ActiveRecord::Migration
  def change
    create_table :f1_households do |t|
      # t.integer :f1_id, null: false, unique: true
      t.string :uri
      t.integer :old_id
      t.string :h_code
      t.string :household_name
      t.string :household_sort_name
      t.string :household_first_name
      t.datetime :last_security_authorization
      t.datetime :last_activity_date

      t.timestamps null: false
    end

    add_index :f1_households, :household_name
    add_index :f1_households, :household_sort_name
    add_index :f1_households, :household_first_name
  end
end
