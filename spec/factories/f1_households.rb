# == Schema Information
#
# Table name: f1_households
#
#  id                          :integer          not null, primary key
#  uri                         :string
#  old_id                      :integer
#  h_code                      :string
#  household_name              :string
#  household_sort_name         :string
#  household_first_name        :string
#  last_security_authorization :datetime
#  last_activity_date          :datetime
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#

FactoryGirl.define do
  factory :f1_household, class: 'F1::Household' do
    
  end
end
