# == Schema Information
#
# Table name: f1_fund_types
#
#  id   :integer          not null, primary key
#  uri  :string
#  name :string
#

class F1::FundType < F1::Base

  has_many :funds, class_name: F1::Fund.name

  def self.group
    'giving'
  end

  def self.base_route
    '/funds/fundtypes'
  end

  def self.f1_attribute_map
    {

    }
  end

  # Total Records
  # 7/27/2017 3
end
