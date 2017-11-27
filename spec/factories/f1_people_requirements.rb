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

FactoryGirl.define do
  factory :f1_people_requirement, class: 'F1::PeopleRequirement' do
    
  end
end
