class CreateF1PeopleRequirements < ActiveRecord::Migration
  def change
    create_table :f1_people_requirements do |t|
      t.string :uri
      t.string :requirement_document_uri
      t.integer :person_id
      t.integer :requirement_id
      t.integer :requirement_status_id
      t.datetime :requirement_date
      t.integer :staff_id
      t.integer :background_check_id

      t.timestamps null: false
    end

    add_index :f1_people_requirements, :person_id
    add_index :f1_people_requirements, :requirement_id
    add_index :f1_people_requirements, :requirement_status_id
    add_index :f1_people_requirements, :staff_id
    add_index :f1_people_requirements, :background_check_id
  end
end
