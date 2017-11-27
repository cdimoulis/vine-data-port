class CreateF1ContributionSubTypes < ActiveRecord::Migration
  def change
    create_table :f1_contribution_sub_types do |t|
      t.string :uri
      t.string :name
      t.integer :contribution_type_id

      # t.timestamps null: false
    end
    add_index :f1_contribution_sub_types, :contribution_type_id
  end
end
