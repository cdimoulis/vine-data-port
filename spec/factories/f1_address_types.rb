# == Schema Information
#
# Table name: f1_address_types
#
#  id   :integer          not null, primary key
#  name :string
#  uri  :string
#

FactoryGirl.define do
  factory :f1_address_type, class: 'F1::AddressType' do
    
  end
end
