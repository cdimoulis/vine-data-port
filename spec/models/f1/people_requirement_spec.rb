# == Schema Information
#
# Table name: f1_people_requirements
#
#  id                       :integer          not null, primary key
#  uri                      :string
#  requirement_document_uri :string
#  person_id                :integer
#  requirement_id           :integer
#  requirement_status_id    :integer
#  requirement_date         :datetime
#  staff_id                 :integer
#  background_check_id      :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

require 'rails_helper'

RSpec.describe F1::PeopleRequirement, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
