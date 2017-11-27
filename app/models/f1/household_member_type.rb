# == Schema Information
#
# Table name: f1_household_member_types
#
#  id   :integer          not null, primary key
#  name :string
#  uri  :string
#

class F1::HouseholdMemberType < F1::Base

  has_many :people, class_name: F1::Person.name

  def self.base_route
    '/people/householdmembertypes'
  end

  # Total Records
  # 7/29/2017 5
end
