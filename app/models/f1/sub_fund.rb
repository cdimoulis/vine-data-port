# == Schema Information
#
# Table name: f1_sub_funds
#
#  id             :integer          not null, primary key
#  uri            :string
#  old_id         :integer
#  fund_id        :integer
#  name           :string
#  general_ledger :string
#  sub_fund_code  :string
#  is_web_enabled :boolean
#  is_active      :boolean
#  created_by_id  :integer
#  updated_by_id  :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class F1::SubFund < F1::Base

  belongs_to :fund, class_name: F1::Fund.name

  def self.group
    'giving'
  end

  def self.base_route
    '/funds'
  end

  def self.f1_attribute_map
    {
      parentFund: 'fund_id',
      createdByPerson: 'created_by_id',
      lastUpdatedByPerson: 'updated_by_id',
      createdDate: 'created_at',
      lastUpdatedDate: 'updated_at'
    }
  end

  def self.find_attributes(force_remote=false)
    fund = F1::Fund.where('id = ?',73146).take
    if force_remote
      fetch_attributes("/#{fund.id}/subfunds")
    else
      begin
        column_names
      rescue
        fetch_attributes("/#{fund.id}/subfunds")
      end
    end
  end

  def self.get_all_records(extra_route=nil, data=nil, max_pages=nil)
    data = data || {}

    if F1::Fund.count > 0
      # Get all Funds
      records = []
      F1::Fund.all.each do |fund|
        path = "/#{fund.id}/subfunds"
        rs = super path, data, max_pages
        # Add f1_attribute_group_id to record
        rs.each do |r|
          r['fund_id'] = fund.id
        end
        records += rs
      end
    else
      records = super "/73146/subfunds", data, max_pages
    end
    @total_records = records.length
    records
  end

  # Total Records
  # 7/27/2017 6

  def self.replace_attributes(record, *args)
    record['created_by_id'] = record['created_by_id']['@id']
    record['updated_by_id'] = record['updated_by_id']['@id']

    record
  end
end
