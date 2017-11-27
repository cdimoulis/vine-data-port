# == Schema Information
#
# Table name: f1_communication_types
#
#  id           :integer          not null, primary key
#  uri          :string
#  general_type :string
#  name         :string
#

class F1::CommunicationType < F1::Base

  has_many :communications, class_name: F1::Communication.name

  def self.base_route
    '/communications/communicationtypes'
  end

  def self.f1_attribute_map
    {
      generalType: 'general_type'
    }
  end

  # Total Records
  # 7/29/2017 11
end
