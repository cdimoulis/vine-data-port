# == Schema Information
#
# Table name: f1_occupations
#
#  id   :integer          not null, primary key
#  name :string
#  uri  :string
#

FactoryGirl.define do
  factory :f1_occupation, class: 'F1::Occupation' do
    
  end
end
