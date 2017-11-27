class CreateF1SubStatuses < ActiveRecord::Migration
  def change
    create_table :f1_sub_statuses do |t|
      t.string :name
      t.string :uri
      t.string :status_id

      # t.timestamps null: false
    end

    add_index :f1_sub_statuses, :name
    add_index :f1_sub_statuses, :status_id
  end
end
