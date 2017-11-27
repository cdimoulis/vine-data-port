# == Schema Information
#
# Table name: f1_categories
#
#  id   :integer          not null, primary key
#  name :string
#  uri  :string
#

class F1::Category < F1::Base

  has_many :categories_groups, class_name: F1::CategoriesGroup.name, dependent: :destroy
  has_many :groups, class_name: F1::Group.name, through: :categories_groups

  def self.group
    'groups'
  end

  def self.base_route
    '/categories'
  end

  def self.f1_attribute_map
    {

    }
  end

  # Total Records
  # 7/29/2017 19
end
