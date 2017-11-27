class CreateF1Schools < ActiveRecord::Migration
  def change
    create_table :f1_schools do |t|
      t.string :name
      t.string :uri

      # t.timestamps null: false
    end
    add_index :f1_schools, :name
  end
end
