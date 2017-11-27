# == Schema Information
#
# Table name: f1_batch_statuses
#
#  id   :integer          not null, primary key
#  uri  :string
#  name :string
#

FactoryGirl.define do
  factory :f1_batch_status, class: 'F1::BatchStatus' do
    
  end
end
