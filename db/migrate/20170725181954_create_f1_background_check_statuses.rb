class CreateF1BackgroundCheckStatuses < ActiveRecord::Migration
  def change
    create_table :f1_background_check_statuses do |t|
      t.string :name
      t.string :uri

      # t.timestamps null: false
    end

    add_index :f1_background_check_statuses, :name
  end
end
