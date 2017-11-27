class CreateF1AddressTypes < ActiveRecord::Migration
  def change
    create_table :f1_address_types do |t|
      t.string :name
      t.string :uri

      # t.timestamps null: false
    end
    add_index :f1_address_types, :name
  end
end
