# == Schema Information
#
# Table name: f1_account_type
#
#  id     :integer          not null, primary key
#  uri    :string
#  old_id :integer
#  name   :string
#

class F1::AccountType < F1::Base

  # This shows up as attribute in F1 returned records
  has_many :attrs, class_name: F1::Attribute.name

  def self.base_route
    '/accounts/accounttypes'
  end

  # Total Records
  # 7/29/2017 7

end
