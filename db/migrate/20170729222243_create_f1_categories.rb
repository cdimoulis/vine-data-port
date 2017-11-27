class CreateF1Categories < ActiveRecord::Migration
  def change
    create_table :f1_categories do |t|
      t.string :name
      t.string :uri

      # t.timestamps null: false
    end

    add_index :f1_categories, :name
  end
end
