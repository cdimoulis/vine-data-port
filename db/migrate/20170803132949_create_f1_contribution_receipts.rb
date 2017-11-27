class CreateF1ContributionReceipts < ActiveRecord::Migration
  def change
    create_table :f1_contribution_receipts do |t|
      t.string :uri
      t.integer :old_id
      # t.string :account_reference
      t.float :amount
      t.integer :fund_id
      t.integer :sub_fund_id
      t.integer :pledge_drive_id
      t.integer :household_id
      t.integer :person_id
      t.integer :account_id
      t.integer :reference_image_id
      t.integer :batch_id
      t.integer :activity_instance_id
      t.integer :contribution_type_id
      t.integer :contribution_sub_type_id
      t.datetime :received_date
      t.datetime :transmit_date
      t.datetime :return_date
      t.datetime :retransmit_date
      t.datetime :gl_post_date
      t.boolean :is_split
      t.boolean :address_verification
      t.text :memo
      t.string :stated_value
      t.string :true_value
      t.boolean :thank
      t.datetime :thanked_date
      t.boolean :is_matched
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end

    add_index :f1_contribution_receipts, :fund_id
    add_index :f1_contribution_receipts, :sub_fund_id
    add_index :f1_contribution_receipts, :pledge_drive_id
    add_index :f1_contribution_receipts, :household_id
    add_index :f1_contribution_receipts, :person_id
    add_index :f1_contribution_receipts, :account_id
    add_index :f1_contribution_receipts, :reference_image_id
    add_index :f1_contribution_receipts, :batch_id
    add_index :f1_contribution_receipts, :activity_instance_id
    add_index :f1_contribution_receipts, :contribution_type_id
    add_index :f1_contribution_receipts, :contribution_sub_type_id
  end
end
