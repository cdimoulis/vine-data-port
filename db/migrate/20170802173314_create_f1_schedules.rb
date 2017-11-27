class CreateF1Schedules < ActiveRecord::Migration
  def change
    create_table :f1_schedules do |t|
      t.string :uri
      t.string :name
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.integer :number_recurrences
      t.date :start_date
      t.date :end_date
      t.integer :recurrence_type_id
      t.json :recurrences
      t.integer :event_id
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end

    add_index :f1_schedules, :event_id
    add_index :f1_schedules, :recurrence_type_id
  end
end
