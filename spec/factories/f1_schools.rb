# == Schema Information
#
# Table name: f1_schools
#
#  id   :integer          not null, primary key
#  name :string
#  uri  :string
#

FactoryGirl.define do
  factory :f1_school, class: 'F1::School' do
    
  end
end
