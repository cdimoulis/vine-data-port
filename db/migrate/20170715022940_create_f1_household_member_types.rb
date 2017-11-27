class CreateF1HouseholdMemberTypes < ActiveRecord::Migration
  def change
    create_table :f1_household_member_types do |t|
      # t.integer :f1_id, null: false, unique: true
      t.string :name
      t.string :uri

      # t.timestamps null: false
    end
    add_index :f1_household_member_types, :name
  end
end
