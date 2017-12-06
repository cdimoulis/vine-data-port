# address_id
# person
# household
# address_type
# address_1,
# address_2
# zip_code
# country
# address_comment
# address_last_update,
# address_created_date
# latitude
# longitude

class ALF::Address < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :address_id, :person, :household, :address_type, :address_1,
    :address_2, :zip_code, :country, :address_comment, :address_last_update,
    :address_created_date, :latitude, :longitude

  # Name to be sent in request to API
  def self.alf_name
    "info_address"
  end

  # Primary id key for record
  def self.id_attribute
    'address_id'
  end

  # Belongs to associations
  # :association_name => {class: 'ALF::Classname',
  #                 through: 'attribute in model',
  #                 assoc_attribute: 'matching attribute in association'}
  def self.alf_belongs_to
    {
      :person => {class: "ALF::Person"},
      :household => {class: "ALF::Household"}
    }
  end  ####
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
      addr_type = ALF::AddressType.where('address_type_id', self.address_type).first

      # if it is HOME type then base off of household
      if addr_type.address_type == 'Home'
        prev_id = CIVICRM::ContactPrevId.where(alf_id: self.household).take
      else
        prev_id = CIVICRM::ContactPrevId.where(alf_id: self.person).take
      end

      # if no prev_id then base off of what is found
      if prev_id.nil?
        if self.person.present?
          prev_id = CIVICRM::ContactPrevId.where(alf_id: self.person).take
        else
          prev_id = CIVICRM::ContactPrevId.where(alf_id: self.household).take
        end
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
