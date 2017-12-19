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
  def civicrm_map
    contact = contact_model()
    if !contact.valid? || !contact.save
      raise "Invalid Contact Model\nALF::Person: #{self.inspect}\nCIVICRM::Contact: #{contact.errors.inspect}"
    end

    status = value_assimilation_model(contact)
    if status.nil? || !status.valid? || !status.save
      raise "Invalid ValueAssimilation Model\nALF::Person: #{self.inspect}\nCIVICRM::ValueAssimilation: #{status.errors.inspect}"
    end

    prev_id = prev_id_model(contact)
    if !prev_id.valid? || !prev_id.save
      raise "Invalid VineContactPrevId Model\nCIVICRM::Contact: #{contact.inspect}\nPrevId: #{prev_id.inspect}"
    end
    # in case more needs to be done here
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
      :household_name => self.household_name,
      :created_date => self.person_created_date,
      :modified_date => self.person_last_update_date
    )
  end

  # Pass in a created contact model to associate with this F1 model
  def prev_id_model(contact)
    return if contact.nil? or contact.id.nil? or !CIVICRM::Contact.exists?(contact.id)
    CIVICRM::VineContactPrevId.new(
      contact_id: contact.id,
      alf_id: self.id
    )
  end

  # The CIVICRM membership status
  def value_assimilation_model(contact)
    return if contact.nil? or contact.id.nil? or !CIVICRM::Contact.exists?(contact.id)
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
    alf_prefix = ALF::PersonPrefix.where('prefix_id', self.prefix)[0];
    prefix = CIVICRM::OptionValue.where(option_group_id: og.id, name: alf_prefix.prefix_name).take
    if prefix.present?
      return prefix.value
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

end
