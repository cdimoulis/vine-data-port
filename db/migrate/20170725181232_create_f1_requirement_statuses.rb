class CreateF1RequirementStatuses < ActiveRecord::Migration
  def change
    create_table :f1_requirement_statuses do |t|
      t.string :name
      t.string :uri

      # t.timestamps null: false
    end
    add_index :f1_requirement_statuses, :name
  end
end
