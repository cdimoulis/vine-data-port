# == Schema Information
#
# Table name: f1_attributes
#
#  id                 :integer          not null, primary key
#  uri                :string
#  old_id             :integer
#  name               :string
#  attribute_group_id :integer
#

FactoryGirl.define do
  factory :f1_attribute, class: 'F1::Attribute' do

  end
end
