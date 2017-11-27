# == Schema Information
#
# Table name: f1_denominations
#
#  id   :integer          not null, primary key
#  name :string
#  uri  :string
#

class F1::Denomination < F1::Base

  has_many :people, class_name: F1::Person.name

  def self.base_route
    '/people/denominations'
  end

  def self.f1_attribute_map
    {

    }
  end

  # Total Records
  # 7/29/2017 35
end
