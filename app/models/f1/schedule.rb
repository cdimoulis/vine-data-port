# == Schema Information
#
# Table name: f1_schedules
#
#  id                 :integer          not null, primary key
#  uri                :string
#  name               :string
#  description        :text
#  start_time         :datetime
#  end_time           :datetime
#  number_recurrences :integer
#  start_date         :date
#  end_date           :date
#  recurrence_type_id :integer
#  recurrences        :json
#  event_id           :integer
#  created_by_id      :integer
#  updated_by_id      :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class F1::Schedule < F1::Base

  belongs_to :event, class_name: F1::Event.name
  belongs_to :recurrence_type, class_name: F1::RecurrenceType.name

  def self.group
    'events'
  end

  def self.base_route
    '/events'
  end

  def self.f1_attribute_map
    {
      recurrenceType: 'recurrence_type_id',
      createdByPerson: 'created_by_id',
      lastUpdatedByPerson: 'updated_by_id',
      createdDate: 'created_at',
      lastUpdatedDate: 'updated_at'
    }
  end

  def self.find_attributes(force_remote=false)
    event = F1::Event.first
    if force_remote
      fetch_attributes "/#{event.id}/schedules"
    else
      begin
        column_names
      rescue
        fetch_attributes "/#{event.id}/schedules"
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
        path = "/#{event.id}/schedules"
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
  # 7/27/2017 107

  def self.replace_attributes(record, *args)
    record['recurrence_type_id'] = record['recurrence_type_id']['@id']
    record['created_by_id'] = record['created_by_id']['@id']
    record['updated_by_id'] = record['updated_by_id']['@id']

    record
  end
end
