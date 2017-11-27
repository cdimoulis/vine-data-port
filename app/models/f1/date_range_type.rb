# == Schema Information
#
# Table name: f1_date_range_types
#
#  id   :integer          not null, primary key
#  name :string
#  uri  :string
#

class F1::DateRangeType < F1::Base

  has_many :groups, class_name: F1::Group.name

  def self.group
    'groups'
  end

  def self.base_route
    '/daterangetypes'
  end

  def self.f1_attribute_map
    {

    }
  end

  # Total Records
  # 7/29/2017 9
end
