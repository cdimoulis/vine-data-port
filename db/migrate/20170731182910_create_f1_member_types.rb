class CreateF1MemberTypes < ActiveRecord::Migration
  def change
    create_table :f1_member_types do |t|
      t.string :uri
      t.string :name
      t.text :description
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end
  end
end
