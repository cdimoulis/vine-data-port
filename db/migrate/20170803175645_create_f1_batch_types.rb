class CreateF1BatchTypes < ActiveRecord::Migration
  def change
    create_table :f1_batch_types do |t|
      t.string :uri
      t.string :name

      # t.timestamps null: false
    end

    add_index :f1_batch_types, :name
  end
end
