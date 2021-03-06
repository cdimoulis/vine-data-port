class ALF::Person < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :person_id, :household, :household_position, :prefix,
    :first_name, :middle_name, :last_name, :suffix, :goes_by, :former_name,
    :gender, :date_of_birth, :marital_status, :membership_status, :status_date,
    :status_comment, :former_church, :person_created_date, :person_last_update_date,
    :person_active, :network_church, :first_time, :second_time, :third_time

  # Name to be sent in request to API
  def self.alf_name
    "info_person"
  end

  # Primary id key for record
  def self.id_attribute
    'person_id'
  end

  # Belongs to associations
  # :association_name => {class: 'ALF::Classname',
  #                 through: 'attribute in model',
  #                 assoc_attribute: 'matching attribute in association'}
  def self.alf_belongs_to
    {
      :household => {class: "ALF::Household"},
      :gender => {class: "ALF::Gender"}
    }
  end

  # Has many associations
  # :association_name => {class: 'ALF::Classname',
  #                 foreign_key: 'attribute with id in association'}
  def self.alf_has_many
    {
      :emails => {class: 'ALF::Email', foreign_key: 'person'},
      :addresses => {class: 'ALF::Address', foreign_key: 'person'},
      :phones => {class: 'ALF::Phone', foreign_key: 'person'}
    }
  end

  ####
  # CIVICRM model mapping
  ####

  # The mapping for civicrm
  def civicrm_models
    contact = contact_model()
    if !contact.valid? || !contact.save
      raise "Invalid Contact Model\nALF::Person: #{self.inspect}\nCIVICRM::Contact: #{contact.errors.inspect}"
    end

    prev_id = prev_id_model(contact)
    if !prev_id.valid? || !prev_id.save
      raise "Invalid VineContactPrevId Model\nCIVICRM::Contact: #{contact.inspect}\nPrevId: #{prev_id.inspect}"
    end

    status = value_assimilation_model(contact)
    if !status.nil? && !status.save
      raise "Invalid ValueAssimilation Model\nALF::Person: #{self.inspect}\nCIVICRM::ValueAssimilation: #{status.errors.inspect}"
    end

    civicrm_emails
    civicrm_phones
    civicrm_addresses
  end

  def contact_model
    CIVICRM::Contact.new(
      :contact_type => "Individual",
      :contact_sub_type => nil,
      :sort_name => self.sort_name,
      :display_name => self.display_name,
      :nick_name => self.goes_by,
      :first_name => self.first_name,
      :middle_name => self.middle_name,
      :last_name => self.last_name,
      :prefix_id => self.prefix_id,
      :suffix_id => self.suffix_id,
      :formal_title => nil,
      :communication_style_id => nil,
      :email_greeting_id => nil,
      :email_greeting_custom => nil,
      :email_greeting_display => nil,
      :addressee_id => 1,
      :addressee_custom => nil,
      :addressee_display => nil,
      :gender_id => self.civicrm_gender_id,
      :birth_date => self.date_of_birth,
      :is_deceased => false,
      :created_date => self.person_created_date,
      :modified_date => self.person_last_update_date
    )
  end

  # Pass in a created contact model to associate with this F1 model
  def prev_id_model(contact)
    return if contact.nil? or contact.id.nil? or !CIVICRM::Contact.exists?(contact.id)
    contact_type = CIVICRM::ContactType.where(name: 'Individual').take
    CIVICRM::VineContactPrevId.new(
      contact_id: contact.id,
      contact_type_id: contact_type.id,
      alf_id: self.person_id
    )
  end

  # The CIVICRM membership status
  def value_assimilation_model(contact)
    return if contact.nil? or contact.id.nil? or !CIVICRM::Contact.exists?(contact.id) or membership_status.nil?
    alf_status = ALF::MembershipStatus.where('membership_status_id', membership_status).first
    if alf_status.present?
      group = CIVICRM::OptionGroup.where(name: 'membership_status_20121112161808').take
      status = CIVICRM::OptionValue.where(option_group_id: group.id, label: alf_status.membership_status_name).take

      CIVICRM::ValueAssimilation.new(
        entity_id: contact.id,
        membership_status_101: status.id
      )
    end
  end


  ###
  # Helper methods for CIVICRM mapping
  ###

  def sort_name
    n = "#{self.last_name}, #{self.first_name}"
    if self.middle_name.present?
      n += " #{self.middle_name}"
    end
    n
  end

  def display_name
    n = "#{self.first_name}"
    if self.middle_name.present?
      n += " #{self.middle_name}"
    end
    n += " #{self.last_name}"
    n
  end

  def prefix_id
    og = CIVICRM::OptionGroup.where(name: 'individual_prefix').take
    alf_prefix = ALF::PersonPrefix.where('prefix_id', self.prefix)[0]
    if alf_prefix.present?
      prefix = CIVICRM::OptionValue.where(option_group_id: og.id, name: alf_prefix.prefix_name).take
      if prefix.present?
        return prefix.value
      end
    end
    return nil
  end

  def suffix_id
    map = {'SR': 'Sr.', 'JR': 'Jr.', 'Jr': 'Jr.'}
    og = CIVICRM::OptionGroup.where(name: 'individual_suffix').take
    alf_suffix = ALF::PersonSuffix.where('suffix_id', self.suffix)[0];
    if alf_suffix.present?
      if map.include?(alf_suffix.suffix_name.to_s)
        alf_suffix.suffix_name = map[alf_suffix.suffix_name.to_s]
      end
      suffix = CIVICRM::OptionValue.where(option_group_id: og.id, name: alf_suffix.suffix_name).take
    end
    if suffix.present?
      return suffix.value
    end
    return nil
  end

  def civicrm_gender_id
    gender = get_belongs_to(:gender)
    if gender.present?
      og = CIVICRM::OptionGroup.where(name: 'gender').take
      c_gender = CIVICRM::OptionValue.where(option_group_id: og.id, name: gender.gender_name).take
      if c_gender
        return c_gender.value
      end
    end
    return nil
  end

  # Save the emails, addresses and phones
  def civicrm_emails
    emails = ALF::Email.where('person', self.person_id)
    prev_id = CIVICRM::VineContactPrevId.where(alf_id: self.person_id).take.contact_id;
    contact = CIVICRM::Contact.find(prev_id)

    emails.each do |e|
      e_type = ALF::EmailType.findId(e.email_type)

      if e_type.present? && (e_type.email_type == 'Personal')
        loc_type = CIVICRM::LocationType.where(name: 'Primary').take
        primary = true
      else
        loc_type = CIVICRM::LocationType.where(name: 'Secondary').take
        primary = false
      end

      email = CIVICRM::Email.new(
        contact_id: contact.id,
        email: e.email_address,
        location_type_id: loc_type.id,
        is_primary: primary
      )

      if !email.valid? || !email.save
        raise "Invalid Email Model\nCIVICRM::Email: #{email.inspect}\nALF::Email: #{e.inspect}\nPerson: #{self.person_id}\n"
      end
    end
  end

  def civicrm_addresses
    prev_id = CIVICRM::VineContactPrevId.where(alf_id: self.person_id).take.contact_id;
    contact = CIVICRM::Contact.find(prev_id)
    addresses = ALF::Address.where('person', self.person_id)

    addresses.each do |address|
      alf_type = ALF::AddressType.where('address_type_id', address.address_type).first
      loc_type = CIVICRM::LocationType.where(name: alf_type.address_type).take
      if loc_type.nil?
        loc_type = CIVICRM::Locationtype.where(name: 'Other').take
      end

      zip = address.zip_code.present? ? address.zip_code.split('-')[0] : nil
      zip_suffix = address.zip_code.present? ? address.zip_code.split('-')[1] : nil
      alf_zip = ALF::Zipcode.where('ZIP', zip).first
      city = alf_zip.present? ? alf_zip.City : nil
      state = alf_zip.present? ? CIVICRM::StateProvince.where(abbreviation: alf_zip.State).take : nil
      country = state.present? ? CIVICRM::Country.where(id: state.country_id).take : nil

      a = CIVICRM::Address.new(
        contact_id: contact.id,
        location_type_id: loc_type.id,
        is_billing: false,
        street_address: address.address_1,
        supplemental_address_1: address.address_2,
        postal_code: zip,
        postal_code_suffix: zip_suffix,
        city: city,
        state_province_id: state.present? ? state.id : nil,
        country_id: country.present? ? country.id : nil,
      )

      if !a.valid? || !a.save
        raise "Invalid Address Model\nCIVICRM::Address: #{a.inspect}\nALF::Address: #{e.inspect}\nPerson: #{self.person_id}\n"
      end
    end
  end

  def civicrm_phones
    phones = ALF::Phone.where('person', self.person_id)
    civi_types = CIVICRM::OptionGroup.where(title: 'Phone Type').take.option_values
    prev_id = CIVICRM::VineContactPrevId.where(alf_id: self.person_id).take.contact_id;
    contact = CIVICRM::Contact.find(prev_id)

    phones.each do |p|
      p_type = ALF::PhoneType.findId(p.phone_type)

      if p_type.phone_type == 'Work'
        loc_type = CIVICRM::LocationType.where(name: 'Work').take
      else
        loc_type = CIVICRM::LocationType.where(name: 'Home').take
      end

      phn_type = civi_types.where(name: p_type.phone_type).take
      if phn_type.nil?
        phn_type = civi_types.where(name: 'Phone').take
      end

      phone = CIVICRM::Phone.new(
        contact_id: contact.id,
        location_type_id: loc_type.id,
        phone: p.phone_number,
        phone_type_id: phn_type.id
      )

      if !phone.valid? || !phone.save
        raise "Invalid Phone Model\nCIVICRM::Phone: #{phone.inspect}\nALF::Phone: #{p.inspect}\nPerson: #{self.person_id}\n"
      end
    end
  end

  # Set relationship to household
  def householdRelation()
    p_prev_id = CIVICRM::VineContactPrevId.where(alf_id: self.person_id).take.contact_id
    h_prev = CIVICRM::VineContactPrevId.where(alf_id: self.household).take
    return if h_prev.nil?
    h_prev_id = h_prev.contact_id

    person = CIVICRM::Contact.find(p_prev_id)
    house = CIVICRM::Contact.find(h_prev_id)

    household_type = ALF::HouseholdPosition.findId(self.household_position)

    # Get relationships
    # head - a    household - b
    head_household = CIVICRM::RelationshipType.where(id: 6).take
    # child - a   parent - b
    child_parent = CIVICRM::RelationshipType.where(id: 1).take
    # spouse - a/b
    spouse_rel = CIVICRM::RelationshipType.where(id: 2).take
    # sibling - a/b
    sibling = CIVICRM::RelationshipType.where(id: 3).take
    # individual - a      household - b
    member_household = CIVICRM::RelationshipType.where(id: 7).take

    if household_type.present? && household_type.household_position_name == "Head"
      rel = CIVICRM::Relationship.new(
        contact_id_a: person.id,
        contact_id_b: house.id,
        relationship_type_id: head_household.id
      )
    elsif household_type.present? && household_type.household_position_name == "Spouse"
      rel = CIVICRM::Relationship.new(
        contact_id_a: person.id,
        contact_id_b: house.id,
        relationship_type_id: member_household.id
      )

      head = CIVICRM::Relationship.where(contact_id_b: house.id, relationship_type_id: head_household.id).take
      if head.present?
        # Create spouse relationship
        sp = CIVICRM::Relationship.new(
          contact_id_a: head.contact_id_a,
          contact_id_b: person.id,
          relationship_type_id: spouse_rel.id
        )

        sp.save
      else
        rel = CIVICRM::Relationship.new(
          contact_id_a: person.id,
          contact_id_b: house.id,
          relationship_type_id: member_household.id
        )
      end
      rel.save
    end
  end
end
