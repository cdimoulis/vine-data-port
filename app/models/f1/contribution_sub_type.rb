# == Schema Information
#
# Table name: f1_contribution_sub_types
#
#  id                   :integer          not null, primary key
#  uri                  :string
#  name                 :string
#  contribution_type_id :integer
#

class F1::ContributionSubType < F1::Base

  belongs_to :contribution_type, class_name: F1::ContributionType.name

  def self.group
    'giving'
  end

  def self.base_route
    '/contributiontypes'
  end

  def self.f1_attribute_map
    {

    }
  end

  def self.find_attributes(force_remote=false)
    contribution_type = F1::ContributionType.first
    if force_remote
      fetch_attributes("/#{contribution_type.id}/contributionsubtypes")
    else
      begin
        column_names
      rescue
        fetch_attributes("/#{contribution_type.id}/contributionsubtypes")
      end
    end
  end

  def self.get_all_records(extra_route=nil, data=nil, max_pages=nil)
    data = data || {}

    if F1::ContributionType.count > 0
      # Get all ContributionTypes
      records = []
      F1::ContributionType.all.each do |contribution_type|
        path = "/#{contribution_type.id}/contributionsubtypes"
        rs = super path, data, max_pages
        # Add f1_attribute_group_id to record
        rs.each do |r|
          r['contribution_type_id'] = contribution_type.id
        end
        records += rs
      end
    else
      records = super "/73146/subfunds/contributionsubtypes", data, max_pages
    end
    @total_records = records.length
    records
  end

  # Total Records
  # 7/27/2017 7
end
