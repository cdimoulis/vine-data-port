# == Schema Information
#
# Table name: f1_categories
#
#  id   :integer          not null, primary key
#  name :string
#  uri  :string
#

FactoryGirl.define do
  factory :f1_category, class: 'F1::Category' do
    
  end
end
