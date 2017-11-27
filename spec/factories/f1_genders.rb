# == Schema Information
#
# Table name: f1_genders
#
#  id   :integer          not null, primary key
#  name :string
#  uri  :string
#

FactoryGirl.define do
  factory :f1_gender, class: 'F1::Gender' do
    
  end
end
