# == Schema Information
#
# Table name: f1_statuses
#
#  id   :integer          not null, primary key
#  name :string
#  uri  :string
#

FactoryGirl.define do
  factory :f1_status, class: 'F1::Status' do
    
  end
end
