# == Schema Information
#
# Table name: f1_funds
#
#  id             :integer          not null, primary key
#  uri            :string
#  old_id         :integer
#  name           :string
#  fund_type_id   :integer
#  fund_code      :string
#  is_web_enabled :boolean
#  is_active      :boolean
#  created_by_id  :integer
#  updated_by_id  :integer
#  created_at     :datetime
#  updated_at     :datetime
#

# INcludes offering, tithe, and other giving 'categories'

# fund_type_id = 1 (contribution) maps to CIVICRM::FinancialType is_deductible=true

# Names:
#       3 on 3 Basketball Tournament
#       Building giving
#       Cedar Heights Church
#       Cedar Heights Offering
#       Christland Team Offering
#       Church Plant Endowment
#       Church Plant Offering
#       Church Plant Team T&O
#       Future Church Plants
#       Hope and Healing
#       Marriage Retreat
#       Marriage Retreat 2010
#       Missions (for testing purpose)
#       North Building
#       North Pines
#       Offering
#       Online Offering
#       Online Tithe
#       Other
#       Project Compassion
#       Rock Hills Church
#       Rock Hills Offering
#       Scholarships
#       Special Offering
#       Summer & Area Conference
#       Thanksgiving Offering
#       Tithe
#       VFL Registration
#       Whole Church Retreat
#       Women's Conference
#       Women's Retreat
#       Youth Summer Camp
#       Youth Vkids Discipleship Class
#       Youth Winter Retreat

class F1::Fund < F1::Base

  belongs_to :fund_type, class_name: F1::FundType.name
  has_many :sub_fund, class_name: F1::SubFund.name
  has_many :contribution_receipts

  def self.group
    'giving'
  end

  def self.base_route
    '/funds'
  end

  def self.f1_attribute_map
    {
      fundType: 'fund_type_id',
      accountReference: nil,
      createdByPerson: 'created_by_id',
      lastUpdatedByPerson: 'updated_by_id',
      createdDate: 'created_at',
      lastUpdatedDate: 'updated_at'
    }
  end

  # Total Records
  # 7/27/2017 34

  def self.replace_attributes(record, *args)
    record['fund_type_id'] = record['fund_type_id']['@id']
    record['created_by_id'] = record['created_by_id']['@id']
    record['updated_by_id'] = record['updated_by_id']['@id']

    record
  end



  ####
  # CIVICRM model mapping
  ####

  # The mapping to civicrm
  def civicrm_models
    fund = financial_type_model()
    if !fund.valid? || !fund.save
      raise "Invalid Fund Model\nF1::Fund: #{self.inspect}\nCIVICRM::FinancialType: #{fund.errors.inspect}\n\n"
    end
  end

  # Create the contact model
  def financial_type_model
    CIVICRM::FinancialType.new(
      name: self.name,
      is_deductible: fund_type.name == "Contribution",
      is_active: is_active
    )
  end

  # Create all missing models
  def self.civicrm_create_all
    start = CIVICRM::FinancialType.count
    F1::Fund.all.each do |f|
      found = CIVICRM::FinancialType.where(name: f.name).take
      if (found.nil?)
        f.civicrm_models()
      end
    end
    puts "\nCreated: #{CIVICRM::FinancialType.count - start} CIVICRM::FinancialType records From F1::Fund records\n"
  end

end
