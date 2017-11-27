# == Schema Information
#
# Table name: f1_batch_types
#
#  id   :integer          not null, primary key
#  uri  :string
#  name :string
#

FactoryGirl.define do
  factory :f1_batch_type, class: 'F1::BatchType' do
    
  end
end
