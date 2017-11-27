class CreateF1Groups < ActiveRecord::Migration
  def change
    create_table :f1_groups do |t|
      t.string :uri
      t.string :name
      t.text :description
      t.datetime :start_date
      t.datetime :expiration_date
      t.boolean :is_open
      t.boolean :is_public
      t.boolean :has_childcare
      t.boolean :is_searchable
      t.integer :campus_id
      t.integer :group_type_id
      t.string :group_url
      t.integer :timezone_id
      t.integer :gender_id
      t.integer :marital_status_id
      t.string :start_age_range
      t.string :end_age_range
      t.integer :date_range_type_id
      t.string :leaders_count
      t.string :members_count
      t.string :open_prospects_count
      t.integer :event_id
      t.integer :location_id
      t.boolean :is_location_private
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end

    add_index :f1_groups, :campus_id
    add_index :f1_groups, :group_type_id
    add_index :f1_groups, :timezone_id
    add_index :f1_groups, :gender_id
    add_index :f1_groups, :marital_status_id
    add_index :f1_groups, :date_range_type_id
    add_index :f1_groups, :event_id
    add_index :f1_groups, :location_id
  end
end
