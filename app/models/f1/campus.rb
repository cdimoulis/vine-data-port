# == Schema Information
#
# Table name: f1_campuses
#
#  id   :integer          not null, primary key
#  name :string
#  uri  :string
#
class F1::Campus < F1::Base
  self.table_name = 'f1_campuses'

  has_many :groups, class_name: F1::Group.name

  def self.group
    'groups'
  end

  def self.base_route
    '/campuses'
  end

  def self.f1_attribute_map
    {

    }
  end
end
