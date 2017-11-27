class CreateF1RecurrenceTypes < ActiveRecord::Migration
  def change
    create_table :f1_recurrence_types do |t|
      t.string :uri
      t.string :name

      # t.timestamps null: false
    end
  end
end
