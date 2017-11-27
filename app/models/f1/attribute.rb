# == Schema Information
#
# Table name: f1_attributes
#
#  id                 :integer          not null, primary key
#  uri                :string
#  old_id             :integer
#  name               :string
#  attribute_group_id :integer
#

class F1::Attribute < F1::Base

  # This shows up as attribute in F1 returned records
  belongs_to :attribute_group, class_name: F1::AttributeGroup.name

  def self.base_route
    '/people/attributegroups'
  end

  def self.f1_attribute_map
    {
      # This is actually not returned in F1 records,
      # assumed due to nested url fetch and recorded for documentation
      attributeGroup: 'attribute_group_id'
    }
  end

  def self.find_attributes(force_remote=false)
    if force_remote
      fetch_attributes('/15715/attributes')
    else
      begin
        column_names
      rescue
        fetch_attributes('/15715/attributes')
      end
    end
  end

  def self.get_all_records(extra_route=nil, data=nil, max_pages=nil)
    data = data || {}

    if F1::AttributeGroup.count > 0
      # Get all AttributeGroups
      records = []
      F1::AttributeGroup.all.each do |ag|
        path = "/#{ag.id}/attributes"
        rs = super path, data, max_pages
        # Add attributeGroup
        rs.each do |r|
          r['attributeGroup'] = ag.attributes
        end
        records += rs
      end
    else
      records = super "/15715/attributes", data, max_pages
    end
    @total_records = records.length
    records
  end

  # Total Records
  # 7/29/2017 39

  def self.replace_attributes(record, *args)
    record['attribute_group_id'] = record['attribute_group_id']['id']
    record
  end

  # Total Records
  # 7/29/2017 39
end
