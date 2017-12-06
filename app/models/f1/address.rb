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

  ####
  # CIVICRM model mapping
  ####

  # The mapping to civicrm
  def civicrm_models
    address = address_model()
    if !address.valid? || !address.save
      raise "Invalid Address Type Model\nF1::Address: #{self.inspect}\nCIVICRM::Address: #{address.errors.inspect}"
    end
    # in case more needs to be done here
  end

  # Create the contact model
  def address_model
    a = CIVICRM::Address.new(
      contact_id: self.contact_id,
      location_type_id: self.location_type_id,
      is_primary: self.primary,
      is_billing: false,
      street_address: self.address1,
      street_number: self.street_number,
      supplemental_address_1: self.address2,
      supplemental_address_2: self.address3,
      city: self.city

    )
    # Add county, state, country, and zipcode stuff now
    self.set_location(a)
  end

  # Get the contact_id corresponding to the F1 person model
  # NOTE:
  #  If the type is Home it should be associated with the household_id
  #  currently f1 doesn't have a home type so...
  def contact_id
    if self.person_id.present?
      prev_id = CIVICRM::ContactPrevId.where(f1_id: self.person_id).take
    else
      prev_id = CIVICRM::ContactPrevId.where(f1_id: self.household_id).take
    end

    return if prev_id.nil?
    contact = CIVICRM::Contact.where(id: prev_id.contact_id).take

    return if contact.nil?
    return contact.id
  end

  # Location type id through the address type name
  def location_type_id
    f1_type = F1::AddressType.where(id: self.address_type_id).take
    return if f1_type.nil?

    location_type = CIVICRM::LocationType.where(name: f1_type.name).take
    return if location_type.nil?

    location_type.id
  end

  # If the name of the address type is primary
  def primary
    f1_type = F1::AddressType.where(id: self.address_type_id).take
    return if f1_type.nil?

    return f1_type.name == 'Primary'
  end

  # Take the first part of address 1 and attempt to make it a number
  def street_number
    return if address1.nil?

    num = address1.split(' ')[0].to_i
    if !num.nil? and !(num == 0)
      return num
    end
  end


  # Add in county, state, country, and zipcode based on zip code
  # 1. Get zipcode record from ALF
  # 2. If record found
  #    a. Replace city (to be sure it is correct)
  #    b. Add county_id, state_province_id, zipcode
  # 3. If NOT found
  #    a. use county/state string to find record in CIVICRM
  #    b. if no county/state record found create one
  #    c. add that id to the record
  def set_location(civicrm_model)
    # Split in case suffix is in postal code
    zip = self.postal_code.split('-')[0]
    alf_zip = ALF::Zipcode.where('ZIP', zip).first

    # Set country based on
    country = CIVICRM::Country.where(iso_code: self.country).take

    # If zip is found use to populate civicrm model
    if alf_zip.present?
      civicrm_model.city = alf_zip.City

      # Get the state from CIVICRM
      state = CIVICRM::StateProvince.where(abbreviation: alf_zip.State).take
      # IF state then add
      if state.present?
        civicrm_model.state_province_id = state.id
        # set country in case it is in F1 wrong
        country = CIVICRM::Country.where(id: state.country_id).take
      # Otherwise try to create a state
      else
        # Cannot create without a country
        if country.present?
          state = CIVICRM::StateProvince.new(name: alf_zip.State, abbreviation: alf_zip.State, country_id: country.id)
          # If this state is saved then set it to MODEL
          if state.valid? && state.save
            civicrm_model.state_province_id = state.id
          end
        end
      end

      # Get the county from CIVICRM (after state since we need state)
      county = CIVICRM::County.where('lower(name) = ?', alf_zip.County.downcase).take
      # If county then add
      if county.present?
        civicrm_model.county_id = county.id
      # Otherwise try to create the county
      else
        # Cannot create without a state
        if state.present?
          county = CIVICRM::County.new(name: alf_zip.County, state_province_id: state.id)
          if county.valid? && county.save
            civicrm_model.county_id = county.id
          end
        end
      end

      # Set country
      if country.present?
        civicrm_model.country_id = country.id
      end

    # IF an ALF zipcode model is not found
    else
      # check for state from f1 address model
      state = CIVICRM::StateProvince.where(abbreviation: self.st_province).take
      if state.present?
        civicrm_model.state_province_id = state.id
      end

      # check for county from f1 address model
      county = CIVICRM::StateProvince.where(abbreviation: self.county).takd
      if county.present?
        civicrm_model.county_id = county.id
      end

      # Add country if found
      if country.present?
        civicrm_model.country_id = country.id
      end

    end

    # Set zip codes
    civicrm_model.postal_code = self.postal_code.split('-')[0]
    civicrm_model.postal_code_suffix = self.postal_code.split('-')[1]

    civicrm_model
  end
end
