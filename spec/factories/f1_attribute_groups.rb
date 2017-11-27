# == Schema Information
#
# Table name: f1_attribute_groups
#
#  id     :integer          not null, primary key
#  uri    :string
#  old_id :integer
#  name   :string
#

FactoryGirl.define do
  factory :f1_attribute_group, class: 'F1::AttributeGroup' do
    
  end
end
