# == Schema Information
#
# Table name: f1_categories_groups
#
#  id          :integer          not null, primary key
#  category_id :integer
#  group_id    :integer
#

FactoryGirl.define do
  factory :f1_categories_group, class: 'F1::CategoriesGroup' do
    
  end
end
