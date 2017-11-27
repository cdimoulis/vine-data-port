class CreateCivicrmContactPrevId < ActiveRecord::Migration
  def change
    create_table :civicrm_contact_prev_id, id: false do |t|
      t.column :id, 'integer unsigned auto_increment PRIMARY KEY'
      t.column :contact_id, 'integer unsigned', null: false
      t.column :f1_id, 'integer unsigned'
      t.column :alf_id, 'integer unsigned'
    end
  end
end
