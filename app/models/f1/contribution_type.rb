# == Schema Information
#
# Table name: f1_contribution_types
#
#  id   :integer          not null, primary key
#  uri  :string
#  name :string
#

class F1::ContributionType < F1::Base

  has_many :contribution_receipts, class_name: F1::ContributionReceipt.name

  def self.group
    'giving'
  end

  def self.base_route
    '/contributiontypes'
  end

  def self.f1_attribute_map
    {

    }
  end

  # Total Records
  # 7/27/2017 6
end
