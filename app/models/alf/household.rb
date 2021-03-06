class ALF::Household < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :household_id, :household_name, :household_comment,
    :household_last_update, :household_created_date

  # Name to be sent in request to API
  def self.alf_name
    'info_household'
  end

  # Primary id key for record
  def self.id_attribute
    'household_id'
  end

  # Belongs to associations
  # :association_name => {class: 'ALF::Classname',
  #                 through: 'attribute in model',
  #                 assoc_attribute: 'matching attribute in association'}
  def self.alf_belongs_to
    {

    }
  end

  # Has many associations
  # :association_name => {class: 'ALF::Classname',
  #                 foreign_key: 'attribute with id in association'}
  def self.alf_has_many
    {

    }
  end


  ####
  # CIVICRM model mapping
  ####

  # The mapping to civicrm
  def civicrm_models
    household = contact_model()
    if !household.valid? || !household.save
      raise "Invalid Contact Model\nALF::Household: #{self.inspect}\nCIVICRM::Contact: #{contact.errors.inspect}"
    end

    prev_id = prev_id_model(household)
    if !prev_id.valid? || !prev_id.save
      raise "Invalid VineContactPrevId Model\nCIVICRM::Contact: #{contact.inspect}\nPrevId: #{prev_id.inspect}"
    end

    civicrm_phones
    civicrm_addresses
  end

  def contact_model
    CIVICRM::Contact.new(
      :contact_type => "Household",
      :contact_sub_type => "Family",
      :sort_name => self.household_name,
      :display_name => self.household_name,
      :preferred_mail_format => 'Both', # Every record appears to have this
      :communication_style_id => nil,
      :email_greeting_id => nil,
      :email_greeting_custom => nil,
      :email_greeting_display => nil,
      :addressee_id => 1,
      :addressee_custom => nil,
      :addressee_display => nil,
      :household_name => self.household_name,
    )
  end

  # Pass in a created contact model to associate with this F1 model
  def prev_id_model(contact)
    return if contact.nil? or contact.id.nil? or !CIVICRM::Contact.exists?(contact.id)
    contact_type = CIVICRM::ContactType.where(name: 'Household').take
    CIVICRM::VineContactPrevId.new(
      contact_id: contact.id,
      contact_type_id: contact_type.id,
      alf_id: self.household_id
    )
  end

  def civicrm_addresses
    prev_id = CIVICRM::VineContactPrevId.where(alf_id: self.household_id).take.contact_id;
    contact = CIVICRM::Contact.find(prev_id)
    addresses = ALF::Address.where('household', self.household_id)

    addresses.each do |address|
      next if !address.person.nil?

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
        raise "Invalid Address Model\nCIVICRM::Address: #{a.inspect}\nALF::Address: #{e.inspect}\nHousehold: #{self.household_id}\n"
      end
    end
  end

  def civicrm_phones
    phones = ALF::Phone.where('household', self.household_id)
    civi_types = CIVICRM::OptionGroup.where(title: 'Phone Type').take.option_values
    prev_id = CIVICRM::VineContactPrevId.where(alf_id: self.household_id).take.contact_id;
    contact = CIVICRM::Contact.find(prev_id)

    phones.each do |p|
      next if !p.person.nil?

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
        raise "Invalid Phone Model\nCIVICRM::Phone: #{phone.inspect}\nALF::Phone: #{p.inspect}\nHousehold: #{self.household_id}\n"
      end
    end
  end


  def householdRelations(alf_members)
    household_civi_id = CIVICRM::VineContactPrevId.where(alf_id: self.household_id).take.contact_id
    head_pos = 1
    spouse_pos = 2
    child_pos = 3

    alf_head = alf_members.select { |m| m.household_position == head_pos}[0]
    alf_spouse = alf_members.select { |m| m.household_position == spouse_pos}[0]
    alf_children = alf_members.select { |m| m.household_position == child_pos}

    # Get relationships
    # head - a    household - b
    head_household = CIVICRM::RelationshipType.where(id: 6).take
    # child - a   parent - b
    child_parent = CIVICRM::RelationshipType.where(id: 1).take
    # spouse - a/b
    husband_wife = CIVICRM::RelationshipType.where(id: 2).take
    # sibling - a/b
    sibling = CIVICRM::RelationshipType.where(id: 3).take
    # individual - a      household - b
    member_household = CIVICRM::RelationshipType.where(id: 7).take


    if alf_head.present?
      head_id = CIVICRM::VineContactPrevId.where(alf_id: alf_head.person_id).take.contact_id
      head_rel = CIVICRM::Relationship.new(
        contact_id_a: head_id,
        contact_id_b: household_civi_id,
        relationship_type_id: head_household.id
      )
      head_rel.save
    end

    if alf_spouse.present?
      spouse_id = CIVICRM::VineContactPrevId.where(alf_id: alf_spouse.person_id).take.contact_id
      spouse_rel = CIVICRM::Relationship.new(
        contact_id_a: spouse_id,
        contact_id_b: household_civi_id,
        relationship_type_id: member_household.id
      )
      spouse_rel.save

      if head_id.present?
        hs_rel = CIVICRM::Relationship.new(
          contact_id_a: head_id,
          contact_id_b: spouse_id,
          relationship_type_id: husband_wife.id
        )
        hs_rel.save
      end
    end

    if !alf_children.empty?
      civi_children = []
      alf_children.each do |child|
        child_id = CIVICRM::VineContactPrevId.where(alf_id: child.person_id).take.contact_id
        # CHILD TO HOUSEHOLD
        cr = CIVICRM::Relationship.new(
          contact_id_a: child_id,
          contact_id_b: household_civi_id,
          relationship_type_id: member_household.id
        )
        cr.save

        # CHILD TO PARENT HEAD
        if head_id.present?
          chr = CIVICRM::Relationship.new(
            contact_id_a: head_id,
            contact_id_b: child_id,
            relationship_type_id: child_parent.id
          )
          chr.save
        end

        # CHILD TO PARENT SPOUSE
        if spouse_id.present?
          csr = CIVICRM::Relationship.new(
            contact_id_a: spouse_id,
            contact_id_b: child_id,
            relationship_type_id: child_parent.id
          )
          csr.save
        end

        #SIBLINGS
        civi_children.each do |sib_id|
          sibr = CIVICRM::Relationship.new(
            contact_id_a: sib_id,
            contact_id_b: child_id,
            relationship_type_id: sibling.id
          )
          sibr.save
        end

        civi_children.push(child_id)
      end
    end
  end

end
