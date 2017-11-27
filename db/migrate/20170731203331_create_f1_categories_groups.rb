class CreateF1CategoriesGroups < ActiveRecord::Migration
  def change
    create_table :f1_categories_groups do |t|
      t.integer :category_id
      t.integer :group_id

      # t.timestamps null: false
    end

    add_index :f1_categories_groups, :category_id
    add_index :f1_categories_groups, :group_id
  end
end
