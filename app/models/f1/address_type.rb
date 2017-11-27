# == Schema Information
#
# Table name: f1_address_types
#
#  id   :integer          not null, primary key
#  name :string
#  uri  :string
#

class F1::AddressType < F1::Base

  has_many :addresses, class_name: F1::Address.name

  def self.base_route
    '/addresses/addresstypes'
  end

  def self.f1_attribute_map
    {

    }
  end

  # Total Records
  # 7/29/2017 9
end
