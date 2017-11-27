class CreateF1FundTypes < ActiveRecord::Migration
  def change
    create_table :f1_fund_types do |t|
      t.string :uri
      t.string :name

      # t.timestamps null: false
    end

    add_index :f1_fund_types, :name
  end
end
