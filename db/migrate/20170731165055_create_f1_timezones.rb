class CreateF1Timezones < ActiveRecord::Migration
  def change
    create_table :f1_timezones do |t|
      t.string :name
      t.string :uri

      # t.timestamps null: false
    end
  end
end
