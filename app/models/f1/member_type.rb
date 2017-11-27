# == Schema Information
#
# Table name: f1_member_types
#
#  id            :integer          not null, primary key
#  uri           :string
#  name          :string
#  description   :text
#  created_by_id :integer
#  updated_by_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class F1::MemberType < F1::Base

  def self.group
    'groups'
  end

  def self.base_route
    '/membertypes'
  end

  def self.f1_attribute_map
    {
      createdByPerson: 'created_by_id',
      lastUpdatedByPerson: 'updated_by_id',
      createdDate: 'created_at',
      lastUpdatedDate: 'updated_at'
    }
  end

  # Total Records
  # 7/29/2017 2

  def self.replace_attributes(record, *args)
    record['created_by_id'] = record['created_by_id']['@id']
    record['updated_by_id'] = record['updated_by_id']['@id']
    record
  end
end
