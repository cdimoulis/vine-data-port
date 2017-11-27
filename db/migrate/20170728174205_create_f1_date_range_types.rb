class CreateF1DateRangeTypes < ActiveRecord::Migration
  def change
    create_table :f1_date_range_types do |t|
      t.string :name
      t.string :uri

      # t.timestamps null: false
    end

    add_index :f1_date_range_types, :name
  end
end
