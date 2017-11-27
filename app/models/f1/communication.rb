# == Schema Information
#
# Table name: f1_communications
#
#  id                         :integer          not null, primary key
#  uri                        :string
#  household_id               :integer
#  person_id                  :integer
#  communication_type_id      :integer
#  communication_general_type :string
#  communication_value        :string
#  search_communication_value :string
#  preferred                  :boolean
#  communication_comment      :text
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

class F1::Communication < F1::Base

  belongs_to :communication_type, class_name: F1::CommunicationType.name
  belongs_to :person, class_name: F1::Person.name
  belongs_to :household, class_name: F1::Household.name

  def self.base_route
    ''
  end

  def self.f1_attribute_map
    {
      communicationType: 'communication_type_id',
      household: 'household_id',
      person: 'person_id',
      createdDate: 'created_at',
      lastUpdatedDate: 'updated_at'
    }
  end

  def self.find_attributes(force_remote=false)
    if force_remote
      fetch_attributes '/people/51167288/communications'
    else
      begin
        column_names
      rescue
        fetch_attributes '/people/51167288/communications'
      end
    end
  end

  def self.get_all_records(extra_route=nil, data=nil, max_pages=nil)
    data = data || {}

    if F1::Person.count > 0
      # Loop through people to get their addresses
      count = 0
      records = []
      people = F1::Person.all
      # Specifying a starting page will be used for a starting Person record
      if data[:page].present?
        people = people.offset(data[:page].to_i)
        count = data[:page].to_i
      end
      people.each do |person|
        if max_pages.present?
          break if count >= max_pages
        end
        path = "/people/#{person.id}/communications"
        rs = super path, data, max_pages
        records += rs
        count += 1
        if count%500 == 0
          puts "Person count: #{count} | Current records found: #{records.length}\n"
        end
      end
    end
    @total_records = records.length
    records
  end

  # SHOW IDs
  # Christopher Dimoulis 51167288
  # Dimoulis 31219451

  def self.replace_attributes(record, *args)
    record['household_id'] = record['household_id']['@id']
    record['person_id'] = record['person_id']['@id']
    record['communication_type_id'] = record['communication_type_id']['@id']
    record
  end

  # Total Records
  # 7/28/2017 26,987
end
