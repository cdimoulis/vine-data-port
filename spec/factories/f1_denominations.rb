# == Schema Information
#
# Table name: f1_denominations
#
#  id   :integer          not null, primary key
#  name :string
#  uri  :string
#

FactoryGirl.define do
  factory :f1_denomination, class: 'F1::Denomination' do
    
  end
end
