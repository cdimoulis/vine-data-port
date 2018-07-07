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

# Bad Values
# communication_value: 'AyricaClutts 618-201-0990 or 618-697-0259'

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

  ####
  # CIVICRM model mapping
  ####

  # The mapping to civicrm
  def civicrm_models
    # Only can save email and telephones
    if communication_general_type == 'Email'
      model = email_model
    elsif communication_general_type == 'Telephone'
      model = phone_model
    end

    if model.present?
      if !model.valid? || !model.save
        raise "Invalid communication model:\n#{model.errors.inspect}"
      end
    end

  end

  # Create the contact model
  def email_model
    login = F1::CommunicationType.where(name: 'InFellowship Login').take;
    # If there is a person id then the person_id is the contact id for emails
    if !person_id.nil?
      contact_type = CIVICRM::ContactType.where(name: 'Individual').take
      contact_id = person_id
      has_login = F1::Communication.exists?(communication_general_type: 'Email', person_id: person_id, communication_type_id: login.id)
    # Otherwise find the household
    else
      contact_type = CIVICRM::ContactType.where(name: 'Household').take
      household = F1::Household.where(id: household_id).take
      # If there are people
      if household.present? && household.people.count > 0
        # Get the head of house
        head = F1::HouseholdMemberType.where(name: 'Head').take
        person = household.people.where(household_member_type: head.id).take
        if person.present?
          contact_type = CIVICRM::ContactType.where(name: 'Individual').take
          contact_id = person.id
        # Otherwise get the first person
        else
          contact_type = CIVICRM::ContactType.where(name: 'Individual').take
          contact_id = household.people.first.id
        end
      end
      has_login = F1::Communication.exists?(communication_general_type: 'Email', person_id: contact_id, communication_type_id: login.id)
    end
    # Get civicrm contact id from vine contact prev id table
    prev_id = CIVICRM::VineContactPrevId.where(f1_id: contact_id, contact_type_id: contact_type.id).take
    loc_type = CIVICRM::LocationType.where(name: 'Other').take

    # Main and secondary email
    if !has_login || (self.communication_type.name == "InFellowship Login")
      loc_type = CIVICRM::LocationType.where(name: 'Primary').take
    elsif self.communication_type.name == "Email"
      loc_type = CIVICRM::LocationType.where(name: 'Secondary').take
    end

    CIVICRM::Email.new(
      contact_id: prev_id.contact_id,
      location_type_id: loc_type.id,
      email: communication_value.strip,
      is_primary: self.preferred
    )
  end

  # Create the contact model
  def phone_model
    phone_type = communication_type.name.sub(' Phone', '')
    # Home phone is household
    if phone_type == 'Home'
      contact_type = CIVICRM::ContactType.where(name: 'Household').take
      contact_id = household_id
    # Other wise it is individual
    elsif !person_id.nil?
      contact_type = CIVICRM::ContactType.where(name: 'Individual').take
      contact_id = person_id
    # Unless the individual doesn't exist
    else
      contact_type = CIVICRM::ContactType.where(name: 'Household').take
      contact_id = household_id
    end

    # The contact_id in CIVICRM
    prev_id = CIVICRM::VineContactPrevId.where(f1_id: contact_id, contact_type_id: contact_type.id).take

    # TYPES per discussing with Jason
    # F1            ->     CIVICRM(locationType - option_value)
    # Home Phone            Home - Phone
    # Work Phone            Work - Phone
    # Mobile Phone          Home - Mobile
    # Emergency Phone       Home - Emergency (need to create emergency)

    civi_types = CIVICRM::OptionGroup.where(title: 'Phone Type').take.option_values

    # If phone type is work then location type is work otherwise home
    if phone_type == 'Work'
      loc_type = CIVICRM::LocationType.where(name: 'Work').take
    else
      loc_type = CIVICRM::LocationType.where(name: 'Home').take
    end

    # If phone type is not Home then find it. otherwise type is Phone
    phn_type = civi_types.where(name: phone_type).take
    if phn_type.nil?
      phn_type = civi_types.where(name: 'Phone').take
    end

    if communication_value.length <= 32
      CIVICRM::Phone.new(
        contact_id: prev_id.contact_id,
        location_type_id: loc_type.id,
        phone: communication_value,
        is_primary: preferred,
        phone_type_id: phn_type.value
      )
    end
  end
end
