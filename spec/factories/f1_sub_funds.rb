# == Schema Information
#
# Table name: f1_sub_funds
#
#  id             :integer          not null, primary key
#  uri            :string
#  old_id         :integer
#  fund_id        :integer
#  name           :string
#  general_ledger :string
#  sub_fund_code  :string
#  is_web_enabled :boolean
#  is_active      :boolean
#  created_by_id  :integer
#  updated_by_id  :integer
#  created_at     :datetime
#  updated_at     :datetime
#

FactoryGirl.define do
  factory :f1_sub_fund, class: 'F1::SubFund' do
    
  end
end
