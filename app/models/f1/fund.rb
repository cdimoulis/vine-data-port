# == Schema Information
#
# Table name: f1_funds
#
#  id             :integer          not null, primary key
#  uri            :string
#  old_id         :integer
#  name           :string
#  fund_type_id   :integer
#  fund_code      :string
#  is_web_enabled :boolean
#  is_active      :boolean
#  created_by_id  :integer
#  updated_by_id  :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class F1::Fund < F1::Base

  belongs_to :fund_type, class_name: F1::FundType.name
  has_many :sub_fund, class_name: F1::SubFund.name

  def self.group
    'giving'
  end

  def self.base_route
    '/funds'
  end

  def self.f1_attribute_map
    {
      fundType: 'fund_type_id',
      accountReference: nil,
      createdByPerson: 'created_by_id',
      lastUpdatedByPerson: 'updated_by_id',
      createdDate: 'created_at',
      lastUpdatedDate: 'updated_at'
    }
  end

  # Total Records
  # 7/27/2017 34

  def self.replace_attributes(record, *args)
    record['fund_type_id'] = record['fund_type_id']['@id']
    record['created_by_id'] = record['created_by_id']['@id']
    record['updated_by_id'] = record['updated_by_id']['@id']

    record
  end
end
