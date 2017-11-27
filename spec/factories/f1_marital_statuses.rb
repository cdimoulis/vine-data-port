# == Schema Information
#
# Table name: f1_marital_statuses
#
#  id   :integer          not null, primary key
#  name :string
#  uri  :string
#

FactoryGirl.define do
  factory :f1_marital_status, class: 'F1::MaritalStatus' do
    
  end
end
