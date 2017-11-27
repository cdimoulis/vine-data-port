class CreateF1MaritalStatuses < ActiveRecord::Migration
  def change
    create_table :f1_marital_statuses do |t|
      t.string :name
      t.string :uri

      # t.timestamps null: false
    end

    add_index :f1_marital_statuses, :name
  end
end
