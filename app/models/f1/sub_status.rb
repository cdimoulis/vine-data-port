# == Schema Information
#
# Table name: f1_sub_statuses
#
#  id        :integer          not null, primary key
#  name      :string
#  uri       :string
#  status_id :string
#

class F1::SubStatus < F1::Base

  belongs_to :status, class_name: F1::Status.name

  def self.base_route
    '/people/statuses'
  end

  def self.find_attributes(force_remote=false)
    if force_remote
      fetch_attributes('/18655/substatuses')
    else
      begin
        column_names
      rescue
        fetch_attributes('/18655/substatuses')
      end
    end
  end

  def self.get_all_records(extra_route=nil, data=nil, max_pages=nil)
    data = data || {}

    if F1::Status.count > 0
      # Get all Statuses
      records = []
      F1::Status.all.each do |stat|
        path = "/#{stat.id}/substatuses"
        rs = super path, data, max_pages
        # Add f1_attribute_group_id to record
        rs.each do |r|
          r['status_id'] = stat.id
        end
        records += rs
      end
    else
      records = super "/18655/substatuses", data, max_pages
    end
    @total_records = records.length
    records
  end

  # Total Records
  # 7/29/2017 20
end
