# == Schema Information
#
# Table name: f1_people
#
#  id                       :integer          not null, primary key
#  uri                      :string
#  image_uri                :string
#  old_id                   :integer
#  i_code                   :string
#  household_id             :integer
#  old_household_id         :integer
#  title                    :string
#  salutation               :string
#  prefix                   :string
#  first_name               :string
#  last_name                :string
#  suffix                   :string
#  middle_name              :string
#  goes_by_name             :string
#  former_name              :string
#  gender_id                :integer
#  date_of_birth            :date
#  marital_status           :string
#  household_member_type_id :integer
#  is_authorized            :boolean
#  status_id                :integer
#  occupation_id            :integer
#  employer                 :string
#  school_id                :integer
#  denomination_id          :integer
#  former_church            :string
#  bar_code                 :string
#  member_envelope_code     :string
#  default_tag_comment      :string
#  weblink                  :json
#  solicit                  :string
#  thank                    :boolean
#  first_record             :datetime
#  last_match_date          :datetime
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

class F1::Person < F1::Base

  belongs_to :status, class_name: F1::Status.name
  belongs_to :household_member_type, class_name: F1::HouseholdMemberType.name
  belongs_to :household, class_name: F1::Household.name
  belongs_to :old_household, class_name: F1::Household.name
  belongs_to :denomination, class_name: F1::Denomination.name
  belongs_to :occupation, class_name: F1::Occupation.name
  belongs_to :school, class_name: F1::School.name
  belongs_to :gender, class_name: F1::Gender.name
  has_many :addresses, class_name: F1::Address.name
  has_many :communications, class_name: F1::Communication.name


  # Other possible association needs
  # has_many association with communications (but so can a person's household)
  # has_many association with requirements

  def self.base_route
    '/people'
  end

  def self.f1_attribute_map
    {
      attributes: nil,
      addresses: nil,
      denomination: 'denomination_id',
      householdMemberType: 'household_member_type_id',
      gender: 'gender_id',
      occupation: 'occupation_id',
      school: 'school_id',
      status: 'status_id',
      createdDate: 'created_at',
      lastUpdatedDate: 'updated_at'
    }
  end

  def self.find_attributes(force_remote=false)
    if force_remote
      fetch_attributes('/search', {createdDate: '1975-01-01'})
    else
      begin
        column_names
      rescue
        fetch_attributes('/search', {createdDate: '1975-01-01'})
      end
    end
  end

  def self.get_all_records(extra_route=nil, data=nil, max_pages=nil)
    data = data || {}
    super "/search", {createdDate: '1975-01-01'}.merge(data), max_pages
  end

  # SHOW IDs
  # Christopher Dimoulis 51167288

  # Total Records
  # 7/27/2017  19,031

  def self.replace_attributes(record, *args)
    record['denomination_id'] = record['denomination_id']['@id']
    record['household_member_type_id'] = record['household_member_type_id']['@id']
    record['occupation_id'] = record['occupation_id']['@id']
    record['school_id'] = record['school_id']['@id']
    record['status_id'] = record['status_id']['@id']

    # record['gender_id'] will have the name initially
    gender = F1::Gender.where("name = ?", record['gender_id']).take
    record['gender_id'] = gender.present? ? gender.id : nil
    record
  end

  ####
  # CIVICRM model mapping
  ####

  # The mapping to civicrm
  def civicrm_models
    contact = contact_model()
    if !contact.valid? || !contact.save
      raise "Invalid Contact Model\nF1::Person: #{self.inspect}\nCIVICRM::Contact: #{contact.errors.inspect}"
    end

    status = value_assimilation_model(contact)
    if status.present?
      if !status.valid? || !status.save
        raise "Invalid ValueAssimilation Model\nF1::Person: #{self.inspect}\nCIVICRM::ValueAssimilation: #{status.errors.inspect}"
      end
    else

    end

    prev_id = prev_id_model(contact)
    if !prev_id.valid? || !prev_id.save
      raise "Invalid VineContactPrevId Model\nCIVICRM::Contact: #{contact.inspect}\nPrevId: #{prev_id.inspect}"
    end
    # in case more needs to be done here
  end

  # Create the contact model
  def contact_model
    CIVICRM::Contact.new(
      :contact_type => "Individual",
      :contact_sub_type => nil,
      :sort_name => self.sort_name,
      :display_name => self.display_name,
      :nick_name => self.goes_by_name,
      :preferred_mail_format => 'Both', # Every record appears to have this
      :first_name => self.first_name,
      :middle_name => self.middle_name,
      :last_name => self.last_name,
      :prefix_id => self.prefix_id,
      :suffix_id => self.suffix_id,
      :formal_title => self.title,
      :communication_style_id => nil,
      :email_greeting_id => nil,
      :email_greeting_custom => nil,
      :email_greeting_display => nil,
      :addressee_id => 1,
      :addressee_custom => nil,
      :addressee_display => nil,
      :gender_id => self.civicrm_gender_id,
      :birth_date => self.date_of_birth,
      :is_deceased => self.civicrm_is_deceased,
      :household_name => self.household.household_name,
      :created_date => self.created_at,
      :modified_date => self.updated_at
    )
  end

  # Pass in a created contact model to associate with this F1 model
  def prev_id_model(contact)
    return if contact.nil? or contact.id.nil? or !CIVICRM::Contact.exists?(contact.id)
    CIVICRM::VineContactPrevId.new(
      contact_id: contact.id,
      f1_id: self.id
    )
  end

  # The CIVICRM membership status
  def value_assimilation_model(contact)
    return if contact.nil? or contact.id.nil? or !CIVICRM::Contact.exists?(contact.id)
    if status.present?
      group = CIVICRM::OptionGroup.where(name: 'membership_status_20121112161808').take
      civi_status = CIVICRM::OptionValue.where(option_group_id: group.id, label: status.name).take

      CIVICRM::ValueAssimilation.new(
        entity_id: contact.id,
        membership_status_101: civi_status.id
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
    prefix = CIVICRM::OptionValue.where(option_group_id: og.id, name: self.prefix).take
    if prefix.present?
      return prefix.value
    end
    return nil
  end

  def suffix_id
    map = {'SR': 'Sr.', 'JR': 'Jr.', 'Jr': 'Jr.'}
    og = CIVICRM::OptionGroup.where(name: 'individual_suffix').take
    s = self.suffix
    if map.include?(s.to_s)
      s = map[s.to_s]
    end
    suffix = CIVICRM::OptionValue.where(option_group_id: og.id, name: self.suffix).take
    if suffix.present?
      return suffix.value
    end
    return nil
  end

  def civicrm_gender_id
    if gender.present?
      og = CIVICRM::OptionGroup.where(name: 'gender').take
      c_gender = CIVICRM::OptionValue.where(option_group_id: og.id, name: gender.name).take
      if c_gender
        return c_gender.value
      end
    end
    return nil
  end

  def civicrm_is_deceased
    if status.present?
      return status.name == 'Deceased';
    end
    false
  end


end
