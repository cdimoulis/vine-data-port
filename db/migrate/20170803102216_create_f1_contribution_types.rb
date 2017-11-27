class CreateF1ContributionTypes < ActiveRecord::Migration
  def change
    create_table :f1_contribution_types do |t|
      t.string :uri
      t.string :name

      # t.timestamps null: false
    end

    add_index :f1_contribution_types, :name
  end
end
