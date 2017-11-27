class CreateF1BatchStatuses < ActiveRecord::Migration
  def change
    create_table :f1_batch_statuses do |t|
      t.string :uri
      t.string :name

      # t.timestamps null: false
    end
    add_index :f1_batch_statuses, :name
  end
end
