class CreateF1People < ActiveRecord::Migration
  def change
    create_table :f1_people do |t|
      # t.integer :f1_id, null: false, unique: true
      t.string :uri
      t.string :image_uri
      t.integer :old_id
      t.string :i_code
      t.integer :household_id
      t.integer :old_household_id
      t.string :title
      t.string :salutation
      t.string :prefix
      t.string :first_name
      t.string :last_name
      t.string :suffix
      t.string :middle_name
      t.string :goes_by_name
      t.string :former_name
      t.integer :gender_id
      t.date :date_of_birth
      t.string :marital_status
      t.integer :household_member_type_id
      t.boolean :is_authorized
      t.integer :status_id
      t.integer :occupation_id
      t.string :employer
      t.integer :school_id
      t.integer :denomination_id
      t.string :former_church
      t.string :bar_code
      t.string :member_envelope_code
      t.string :default_tag_comment
      t.json :weblink
      t.string :solicit
      t.boolean :thank
      t.datetime :first_record
      t.datetime :last_match_date

      t.timestamps null: false
    end

    add_index :f1_people, :household_id
    add_index :f1_people, :gender_id
    add_index :f1_people, :household_member_type_id
    add_index :f1_people, :occupation_id
    add_index :f1_people, :school_id
    add_index :f1_people, :denomination_id
  end
end
