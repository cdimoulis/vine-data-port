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

class F1::ContributionReceipt < F1::Base

  belongs_to :fund, class_name: F1::Fund.name
  belongs_to :sub_fund, class_name: F1::SubFund.name
  belongs_to :household, class_name: F1::Household.name
  belongs_to :person, class_name: F1::Person.name
  # belongs_to :batch, class_name: F1::Batch.name
  belongs_to :contribution_type, class_name: F1::ContributionType.name
  # belongs_to :contribution_sub_type, class_name: F1::ContributionSubType.name

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
end
