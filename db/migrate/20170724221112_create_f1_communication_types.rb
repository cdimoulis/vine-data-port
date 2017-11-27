class CreateF1CommunicationTypes < ActiveRecord::Migration
  def change
    create_table :f1_communication_types do |t|
      t.string :uri
      t.string :general_type
      t.string :name

      # t.timestamps null: false
    end

    add_index :f1_communication_types, :name
  end
end
