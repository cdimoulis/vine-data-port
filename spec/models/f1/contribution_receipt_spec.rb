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

require 'rails_helper'

RSpec.describe F1::ContributionReceipt, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
