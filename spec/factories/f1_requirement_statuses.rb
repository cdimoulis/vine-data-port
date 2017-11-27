# == Schema Information
#
# Table name: f1_requirement_statuses
#
#  id   :integer          not null, primary key
#  name :string
#  uri  :string
#

FactoryGirl.define do
  factory :f1_requirement_status, class: 'F1::RequirementStatus' do
    
  end
end
