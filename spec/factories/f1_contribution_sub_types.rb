# == Schema Information
#
# Table name: f1_contribution_sub_types
#
#  id                   :integer          not null, primary key
#  uri                  :string
#  name                 :string
#  contribution_type_id :integer
#

FactoryGirl.define do
  factory :f1_contribution_sub_type, class: 'F1::ContributionSubType' do
    
  end
end
