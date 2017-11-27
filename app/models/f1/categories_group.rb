# == Schema Information
#
# Table name: f1_categories_groups
#
#  id          :integer          not null, primary key
#  category_id :integer
#  group_id    :integer
#

class F1::CategoriesGroup < F1::Base

  belongs_to :category, class_name: F1::Category.name
  belongs_to :group, class_name: F1::Group.name

  # Total Records
  # 8/1/2017  1,574 fetched using categories
end
