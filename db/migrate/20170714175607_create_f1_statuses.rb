class CreateF1Statuses < ActiveRecord::Migration
  def change
    create_table :f1_statuses do |t|
      # t.integer :f1_id, null: false, unique: true
      t.string :name
      t.string :uri

      # t.timestamps null: false
    end
    add_index :f1_statuses, :name
  end
end
