class CreateF1Addresses < ActiveRecord::Migration
  def change
    create_table :f1_addresses do |t|
      t.string :uri
      t.integer :household_id
      t.integer :person_id
      t.integer :address_type_id
      t.text :address1
      t.text :address2
      t.text :address3
      t.string :city
      t.string :postal_code
      t.string :county
      t.string :country
      t.string :st_province
      t.string :carrier_route
      t.string :delivery_point
      t.datetime :address_date
      t.text :address_comment
      t.boolean :usps_verified
      t.datetime :address_verified_date
      t.datetime :last_verification_attempt_date

      t.timestamps null: false
    end

    add_index :f1_addresses, :household_id
    add_index :f1_addresses, :person_id
    add_index :f1_addresses, :address_type_id
  end
end
