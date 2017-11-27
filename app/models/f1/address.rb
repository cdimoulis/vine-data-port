# == Schema Information
#
# Table name: f1_addresses
#
#  id                             :integer          not null, primary key
#  uri                            :string
#  household_id                   :integer
#  person_id                      :integer
#  address_type_id                :integer
#  address1                       :text
#  address2                       :text
#  address3                       :text
#  city                           :string
#  postal_code                    :string
#  county                         :string
#  country                        :string
#  st_province                    :string
#  carrier_route                  :string
#  delivery_point                 :string
#  address_date                   :datetime
#  address_comment                :text
#  usps_verified                  :boolean
#  address_verified_date          :datetime
#  last_verification_attempt_date :datetime
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#

class F1::Address < F1::Base

  belongs_to :address_type, class_name: F1::AddressType.name
  belongs_to :person, class_name: F1::Person.name
  belongs_to :household, class_name: F1::Household.name

  def self.base_route
    ''
  end

  def self.f1_attribute_map
    {
      household: 'household_id',
      person: 'person_id',
      addressType: 'address_type_id',
      createdByPerson: 'created_by_id',
      lastUpdatedByPerson: 'updated_by_id',
      createdDate: 'created_at',
      lastUpdatedDate: 'updated_at'
    }
  end

  def self.find_attributes(force_remote=false)
    if force_remote
      fetch_attributes '/households/31219451/addresses'
    else
      begin
        column_names
      rescue
        fetch_attributes '/households/31219451/addresses'
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
        path = "/people/#{person.id}/addresses"
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
  # Housdhold Address 29635691

  def self.replace_attributes(record, *args)
    record['household_id'] = record['household_id']['@id'] if record.include?('household_id')
    record['person_id'] = record['person_id']['@id'] if record.include?('person_id')
    record['address_type_id'] = record['address_type_id']['@id'] if record.include?('address_type_id')
    record['created_by_id'] = record['created_by_id']['@id'] if record.include?('created_by_id')
    record['updated_by_id'] = record['updated_by_id']['@id'] if record.include?('updated_by_id')
    record
  end

  # Total Records
  # 7/28/2017 11,060
end
