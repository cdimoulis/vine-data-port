# == Schema Information
#
# Table name: f1_recurrence_types
#
#  id   :integer          not null, primary key
#  uri  :string
#  name :string
#

class F1::RecurrenceType < F1::Base

  def self.group
    'events'
  end

  def self.base_route
    '/recurrencetypes'
  end

  def self.f1_attribute_map
    {

    }
  end

  # Total Records
  # 7/29/2017 5
end
