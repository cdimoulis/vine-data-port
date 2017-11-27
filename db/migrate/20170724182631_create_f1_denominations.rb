class CreateF1Denominations < ActiveRecord::Migration
  def change
    create_table :f1_denominations do |t|
      t.string :name
      t.string :uri

      # t.timestamps null: false
    end

    add_index :f1_denominations, :name
  end
end
