# == Schema Information
#
# Table name: f1_statuses
#
#  id   :integer          not null, primary key
#  name :string
#  uri  :string
#

class F1::Status < F1::Base

  has_many :people, class_name: F1::Person.name
  has_many :sub_statuses, class_name: F1::SubStatus.name

  def self.base_route
    '/people/statuses'
  end

  def self.f1_attribute_map
    {
      subStatus: nil
    }
  end

  # Total Records
  # 7/29/2017 20
end
