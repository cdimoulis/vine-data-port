# == Schema Information
#
# Table name: f1_genders
#
#  id   :integer          not null, primary key
#  name :string
#  uri  :string
#

class F1::Gender < F1::Base

  has_many :people, class_name: F1::Person.name
  has_many :groups, class_name: F1::Group.name

  def self.group
    'groups'
  end

  def self.base_route
    '/genders'
  end

  def self.f1_attribute_map
    {

    }
  end

  # Total Records
  # 7/29/2017 3
end
