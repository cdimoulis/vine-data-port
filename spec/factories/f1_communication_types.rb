# == Schema Information
#
# Table name: f1_communication_types
#
#  id           :integer          not null, primary key
#  uri          :string
#  general_type :string
#  name         :string
#

FactoryGirl.define do
  factory :f1_communication_type, class: 'F1::CommunicationType' do
    
  end
end
