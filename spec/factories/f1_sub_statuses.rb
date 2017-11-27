# == Schema Information
#
# Table name: f1_sub_statuses
#
#  id        :integer          not null, primary key
#  name      :string
#  uri       :string
#  status_id :string
#

FactoryGirl.define do
  factory :f1_sub_status, class: 'F1::SubStatus' do
    
  end
end
