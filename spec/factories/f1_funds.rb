# == Schema Information
#
# Table name: f1_funds
#
#  id             :integer          not null, primary key
#  uri            :string
#  old_id         :integer
#  name           :string
#  fund_type_id   :integer
#  fund_code      :string
#  is_web_enabled :boolean
#  is_active      :boolean
#  created_by_id  :integer
#  updated_by_id  :integer
#  created_at     :datetime
#  updated_at     :datetime
#

FactoryGirl.define do
  factory :f1_fund, class: 'F1::Fund' do
    
  end
end
