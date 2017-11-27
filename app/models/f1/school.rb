# == Schema Information
#
# Table name: f1_schools
#
#  id   :integer          not null, primary key
#  name :string
#  uri  :string
#

class F1::School < F1::Base

  has_many :people, class_name: F1::Person.name

  def self.base_route
    '/people/schools'
  end

  def self.f1_attribute_map
    {

    }
  end

  # Total Records
  # 7/29/2017 58
end
