class CreateCivicrmVineContactPrevId < ActiveRecord::Migration
  def change
    create_table :civicrm_vine_contact_prev_id, id: false do |t|
      t.column :id, 'integer unsigned auto_increment PRIMARY KEY'
      t.column :contact_id, 'integer unsigned', null: false
      t.column :f1_id, 'integer unsigned'
      t.column :alf_id, 'integer unsigned'
    end

    add_index :civicrm_vine_contact_prev_id, :contact_id
    add_index :civicrm_vine_contact_prev_id, :f1_id
    add_index :civicrm_vine_contact_prev_id, :alf_id
  end
end
