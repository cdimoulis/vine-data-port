# == Schema Information
#
# Table name: f1_campuses
#
#  id   :integer          not null, primary key
#  name :string
#  uri  :string
#

FactoryGirl.define do
  factory :f1_campus, class: 'F1::Campus' do

  end
end
