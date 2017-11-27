# == Schema Information
#
# Table name: f1_household_member_types
#
#  id   :integer          not null, primary key
#  name :string
#  uri  :string
#

FactoryGirl.define do
  factory :f1_household_member_type, class: 'F1::HouseholdMemberType' do
    
  end
end
