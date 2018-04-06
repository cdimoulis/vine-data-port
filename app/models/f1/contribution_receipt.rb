# == Schema Information
#
# Table name: f1_contribution_receipts
#
#  id                       :integer          not null, primary key
#  uri                      :string
#  old_id                   :integer
#  amount                   :float
#  fund_id                  :integer
#  sub_fund_id              :integer
#  pledge_drive_id          :integer
#  household_id             :integer
#  person_id                :integer
#  account_id               :integer
#  reference_image_id       :integer
#  batch_id                 :integer
#  activity_instance_id     :integer
#  contribution_type_id     :integer
#  contribution_sub_type_id :integer
#  received_date            :datetime
#  transmit_date            :datetime
#  return_date              :datetime
#  retransmit_date          :datetime
#  gl_post_date             :datetime
#  is_split                 :boolean
#  address_verification     :boolean
#  memo                     :text
#  stated_value             :string
#  true_value               :string
#  thank                    :boolean
#  thanked_date             :datetime
#  is_matched               :boolean
#  created_by_id            :integer
#  updated_by_id            :integer
#  created_at               :datetime
#  updated_at               :datetime
#

# Fund_id is what is being given to (tithe, offering)
# 3 on 3 Basketball Tournament
# Building giving
# Cedar Heights Church
# Cedar Heights Offering
# Christland Team Offering
# Church Plant Endowment
# Church Plant Offering
# Church Plant Team T&O
# Future Church Plants
# Hope and Healing
# Marriage Retreat
# Marriage Retreat 2010
# Missions (for testing purpose)
# North Building
# North Pines
# Offering
# Online Offering
# Online Tithe
# Other
# Project Compassion
# Rock Hills Church
# Rock Hills Offering
# Scholarships
# Special Offering
# Summer & Area Conference
# Thanksgiving Offering
# Tithe
# VFL Registration
# Whole Church Retreat
# Women's Conference
# Women's Retreat
# Youth Summer Camp
# Youth Vkids Discipleship Class
# Youth Winter Retreat

# Sub fund seems not used...

# Activity instance id is NOT used

# Contribution_type_id is
# 1, "Check"
# 2, "Cash"
# 5, "ACH"
# 3, "Credit Card"
# 4, "Non-Cash"
# 6, "Voucher"]
# Contribution_sub_type_id is specifics like credit card brand

# Pledge Drives
# 3306 - Test
# 4456 - North Building
# 7888 - 2013 Church Plant Offering
# 11386 - Valley Springs Offering
# 12580 - North Pines Offering
# 14476 - Christland Offering

class F1::ContributionReceipt < F1::Base

  belongs_to :fund, class_name: F1::Fund.name
  belongs_to :sub_fund, class_name: F1::SubFund.name
  belongs_to :household, class_name: F1::Household.name
  belongs_to :person, class_name: F1::Person.name
  belongs_to :batch, class_name: F1::Batch.name
  belongs_to :contribution_type, class_name: F1::ContributionType.name
  belongs_to :contribution_sub_type, class_name: F1::ContributionSubType.name

  def self.group
    'giving'
  end

  def self.base_route
    '/contributionreceipts'
  end

  def self.f1_attribute_map
    {
      fund: 'fund_id',
      subFund: 'sub_fund_id',
      accountReference: nil,
      account: 'account_id',
      pledgeDrive: 'pledge_drive_id',
      household: 'household_id',
      person: 'person_id',
      referenceImage: 'reference_image_id',
      batch: 'batch_id',
      activityInstance: 'activity_instance_id',
      contributionSubType: 'contribution_sub_type_id',
      contributionType: 'contribution_type_id',
      createdByPerson: 'created_by_id',
      lastUpdatedByPerson: 'updated_by_id',
      createdDate: 'created_at',
      lastUpdatedDate: 'updated_at'
    }
  end

  def self.find_attributes(force_remote=false)
    if force_remote
      fetch_attributes('/search', {startReceivedDate: '1975-01-01'})
    else
      begin
        column_names
      rescue
        fetch_attributes('/search', {startReceivedDate: '1975-01-01'})
      end
    end
  end

  def self.get_all_records(extra_route=nil, data=nil, max_pages=nil)
    data = data || {}
    super "/search", {startReceivedDate: '1975-01-01'}.merge(data), max_pages
  end

  # Total Records
  # 7/27/2017 135,132

  def self.replace_attributes(record, *args)
    record['fund_id'] = record['fund_id']['@id']
    record['sub_fund_id'] = record['sub_fund_id']['@id']
    record['account_id'] = record['account_id']['@id']
    record['pledge_drive_id'] = record['pledge_drive_id']['@id']
    record['household_id'] = record['household_id']['@id']
    record['person_id'] = record['person_id']['@id']
    record['reference_image_id'] = record['reference_image_id']['@id']
    record['batch_id'] = record['batch_id']['@id']
    record['activity_instance_id'] = record['activity_instance_id']['@id']
    record['contribution_type_id'] = record['contribution_type_id']['@id']
    record['contribution_sub_type_id'] = record['contribution_sub_type_id']['@id']
    record['created_by_id'] = record['created_by_id']['@id']
    record['updated_by_id'] = record['updated_by_id']['@id']

    record
  end

  ####
  # CIVICRM model mapping
  ####

  # The mapping to civicrm
  def civicrm_models
    contribution = contribution_model()
    if !contribution.valid? || !contribution.save
      raise "Invalid Contribution Model\nF1::ContributionReceipt: #{self.inspect}\nCIVICRM::Contribution: #{contribution.errors.inspect}\n\n"
    end
  end

  # Create the contact model
  def contribution_model
    c = CIVICRM::Contribution.new(
      contact_id: self.contact_id,
      financial_type_id: self.financial_type_id,
      payment_instrument_id: self.payment_instrument_id,
    )
  end

  def contact_id
    if self.person_id.present?
      contact_type = CIVICRM::ContactType.where(name: 'Individual').take
      prev_id = CIVICRM::VineContactPrevId.where(f1_id: self.person_id, contact_type_id: contact_type.id).take
    else
      contact_type = CIVICRM::ContactType.where(name: 'Household').take
      prev_id = CIVICRM::VineContactPrevId.where(f1_id: self.household_id, contact_type_id: contact_type.id).take
    end

    return if prev_id.nil?
    contact = CIVICRM::Contact.where(id: prev_id.contact_id).take

    return if contact.nil?
    return contact.id
  end

  def financial_type_id
    # Use fund_id (not batch_id) to get this
  end

  # TODO: I don't know if CIVICRM Financial type id is the value or the id. Think the value
  def payment_instrument_id
    group = F1::OptionGroup.where(name: "payment_instrument").take
    contribution_type_name = contribution_type.name == 'ACH' ? 'EFT' : contribution_type.name
    value = F1::OptionValue.where(option_group_id: group.id, name: contribution_type_name).take
    if value.nil?
      value = CIVICRM::OptionValue.create_new_payment_instrument(contribution_type_name);
    end

    value.value
  end
end
