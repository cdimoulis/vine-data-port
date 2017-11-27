# == Schema Information
#
# Table name: f1_locations
#
#  id            :integer          not null, primary key
#  uri           :string
#  name          :string
#  description   :string
#  event_id      :integer
#  is_online     :boolean
#  url           :string
#  address       :json
#  created_by_id :integer
#  updated_by_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class F1::Location < F1::Base

  belongs_to :event, class_name: F1::Event.name

  def self.group
    'events'
  end

  def self.base_route
    '/events'
  end

  def self.f1_attribute_map
    {
      createdByPerson: 'created_by_id',
      lastUpdatedByPerson: 'updated_by_id',
      createdDate: 'created_at',
      lastUpdatedDate: 'updated_at'
    }
  end

  def self.find_attributes(force_remote=false)
    event = F1::Event.first
    if force_remote
      fetch_attributes "/#{event.id}/locations"
    else
      begin
        column_names
      rescue
        fetch_attributes "/#{event.id}/locations"
      end
    end
  end

  def self.get_all_records(extra_route=nil, data=nil, max_pages=nil)
    data = data || {}

    if F1::Event.count > 0
      # Loop through people to get their addresses
      count = 0
      records = []
      events = F1::Event.all
      # Specifying a starting page will be used for a starting Person record
      if data[:page].present?
        events = events.offset(data[:page].to_i)
        count = data[:page].to_i
      end
      events.each do |event|
        if max_pages.present?
          break if count >= max_pages
        end
        path = "/#{event.id}/locations"
        rs = super path, data, max_pages
        rs.each do |r|
          r['event_id'] = event.id
        end
        records += rs
        count += 1
        if count%500 == 0
          puts "Event count: #{count} | Current records found: #{records.length}\n"
        end
      end
    end
    @total_records = records.length
    records
  end

  # Total Records
  # 7/27/2017 105

  def self.replace_attributes(record, *args)
    addr = F1::Address.replace_attributes(F1::Address.format_keys(F1::Address.replace_keys record['address']))
    record['address'] = addr
    record['created_by_id'] = record['created_by_id']['@id']
    record['updated_by_id'] = record['updated_by_id']['@id']

    record
  end
end
