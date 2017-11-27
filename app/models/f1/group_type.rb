# == Schema Information
#
# Table name: f1_group_types
#
#  id             :integer          not null, primary key
#  name           :string
#  uri            :string
#  description    :string
#  is_web_enabled :boolean
#  is_searchable  :boolean
#  created_by_id  :integer
#  updated_by_id  :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class F1::GroupType < F1::Base

  has_many :groups, class_name: F1::Group.name

  def self.group
    'groups'
  end

  def self.base_route
    '/grouptypes'
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
