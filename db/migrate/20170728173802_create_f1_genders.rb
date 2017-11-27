class CreateF1Genders < ActiveRecord::Migration
  def change
    create_table :f1_genders do |t|
      t.string :name
      t.string :uri

      # t.timestamps null: false
    end

    add_index :f1_genders, :name
  end
end
