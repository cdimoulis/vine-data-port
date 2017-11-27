# == Schema Information
#
# Table name: f1_fund_types
#
#  id   :integer          not null, primary key
#  uri  :string
#  name :string
#

FactoryGirl.define do
  factory :f1_fund_type, class: 'F1::FundType' do
    
  end
end
