class CreateF1Campuses < ActiveRecord::Migration
  def change
    create_table :f1_campuses do |t|
      t.string :name
      t.string :uri

      # t.timestamps null: false
    end

    add_index :f1_campuses, :name
  end
end
