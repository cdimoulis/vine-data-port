# == Schema Information
#
# Table name: f1_addresses
#
#  id                             :integer          not null, primary key
#  uri                            :string
#  household_id                   :integer
#  person_id                      :integer
#  address_type_id                :integer
#  address1                       :text
#  address2                       :text
#  address3                       :text
#  city                           :string
#  postal_code                    :string
#  county                         :string
#  country                        :string
#  st_province                    :string
#  carrier_route                  :string
#  delivery_point                 :string
#  address_date                   :datetime
#  address_comment                :text
#  usps_verified                  :boolean
#  address_verified_date          :datetime
#  last_verification_attempt_date :datetime
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#

FactoryGirl.define do
  factory :f1_address, class: 'F1::Address' do
    
  end
end
