# == Schema Information
#
# Table name: f1_background_check_statuses
#
#  id   :integer          not null, primary key
#  name :string
#  uri  :string
#

FactoryGirl.define do
  factory :f1_background_check_status, class: 'F1::BackgroundCheckStatus' do
    
  end
end
