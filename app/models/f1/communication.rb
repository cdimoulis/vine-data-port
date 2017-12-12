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
  # 7/28/2017 26,987####
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
    # If there is a person id then the person_id is the contact id for emails
    if !person_id.nil?
      contact_id = person_id
    # Otherwise find the household
    else
      household = F1::Household.where(id: household_id).take
      # If there are people
      if household.present? && household.people.count > 0
        # Get the head of house
        head = F1::HouseholdMemberType.where(name: 'Head').take
        person = household.people.where(household_member_type: head.id)
        if person.present?
          contact_id = person.id
        # Otherwise get the first person
        else
          contact_id = household.people.first.id
        end
      end
    end

    type = CIVICRM::LocationType.where(name: 'Home').take

    CIVICRM::Email.new(
      contact_id: contact_id,
      location_type_id: type.id,
      email: communication_value,
      is_primary: preferred
    )
  end

  # Create the contact model
  def phone_model
    phone_type = communication_type.name.sub(' Phone', '')
    # Home phone is household
    if phone_type == 'Home'
      contact_id = household_id
    # Other wise it is individual
    elsif !person_id.nil?
      contact_id = person_id
    # Unless the individual doesn't exist
    else
      contact_id = household_id
    end

    loc_type = CIVICRM::LocationType.where(name: 'Home').take
    types = CIVICRM::OptionGroup.where(title: 'Phone Type').take.option_values

    type = types.where(name: phone_type).take
    if type.nil?
      type = types.where(name: 'Phone').take
    end

    CIVICRM::Phone.new(
      contact_id: contact_id,
      location_type_id: loc_type.id,
      phone: communication_value,
      is_primary: preferred,
      phone_type_id: type.id
    )
  end
end
