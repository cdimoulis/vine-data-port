# == Schema Information
#
# Table name: f1_contribution_types
#
#  id   :integer          not null, primary key
#  uri  :string
#  name :string
#

FactoryGirl.define do
  factory :f1_contribution_type, class: 'F1::ContributionType' do
    
  end
end
