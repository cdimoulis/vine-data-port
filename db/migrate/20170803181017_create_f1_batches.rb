class CreateF1Batches < ActiveRecord::Migration
  def change
    create_table :f1_batches do |t|
      t.string :uri
      t.integer :old_id
      t.string :name
      t.float :amount
      t.integer :batch_type_id
      t.integer :batch_status_id
      t.datetime :batch_date
      t.datetime :received_date
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end

    add_index :f1_batches, :batch_type_id
    add_index :f1_batches, :batch_status_id
  end
end
