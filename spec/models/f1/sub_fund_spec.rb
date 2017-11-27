# == Schema Information
#
# Table name: f1_sub_funds
#
#  id             :integer          not null, primary key
#  uri            :string
#  old_id         :integer
#  fund_id        :integer
#  name           :string
#  general_ledger :string
#  sub_fund_code  :string
#  is_web_enabled :boolean
#  is_active      :boolean
#  created_by_id  :integer
#  updated_by_id  :integer
#  created_at     :datetime
#  updated_at     :datetime
#

require 'rails_helper'

RSpec.describe F1::SubFund, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
