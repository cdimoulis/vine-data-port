# == Schema Information
#
# Table name: f1_people
#
#  id                       :integer          not null, primary key
#  uri                      :string
#  image_uri                :string
#  old_id                   :integer
#  i_code                   :string
#  household_id             :integer
#  old_household_id         :integer
#  title                    :string
#  salutation               :string
#  prefix                   :string
#  first_name               :string
#  last_name                :string
#  suffix                   :string
#  middle_name              :string
#  goes_by_name             :string
#  former_name              :string
#  gender_id                :integer
#  date_of_birth            :date
#  marital_status           :string
#  household_member_type_id :integer
#  is_authorized            :boolean
#  status_id                :integer
#  occupation_id            :integer
#  employer                 :string
#  school_id                :integer
#  denomination_id          :integer
#  former_church            :string
#  bar_code                 :string
#  member_envelope_code     :string
#  default_tag_comment      :string
#  weblink                  :json
#  solicit                  :string
#  thank                    :boolean
#  first_record             :datetime
#  last_match_date          :datetime
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

require 'rails_helper'

RSpec.describe F1::Person, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
