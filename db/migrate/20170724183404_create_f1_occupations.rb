class CreateF1Occupations < ActiveRecord::Migration
  def change
    create_table :f1_occupations do |t|
      t.string :name
      t.string :uri

      # t.timestamps null: false
    end
    add_index :f1_occupations, :name
  end
end
