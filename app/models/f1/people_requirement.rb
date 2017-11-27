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

class F1::PeopleRequirement < F1::Base

  belongs_to :person, class_name: F1::Person.name
  belongs_to :requirement, class_name: F1::Requirement.name
  belongs_to :requirement_status, class_name: F1::RequirementStatus.name
  belongs_to :staff, class_name: F1::Person.name, foreign_key: 'staff_id'

  def self.base_route
    '/people/requirements'
  end

  def self.f1_attribute_map
    {
      person: 'person_id',
      requirement: 'requirement_id',
      requirementStatus: 'requirement_status_id',
      staffPerson: 'staff_id',
      backgroundCheck: 'background_check_id',
      createdDate: 'created_at',
      lastUpdatedDate: 'updated_at'
    }
  end

  def self.find_attributes(force_remote=false)
    if force_remote
      fetch_attributes('/search', {createdDate: '1975-01-01'})
    else
      begin
        column_names
      rescue
        fetch_attributes('/search', {createdDate: '1975-01-01'})
      end
    end
  end

  def self.get_all_records(extra_route=nil, data=nil, max_pages=nil)
    data = data || {}
    return_records = []
    super '/search', {createdDate: '1975-01-01'}.merge(data), max_pages
  end

  # REQUIREMENT IDs
  # 14648, 14649, 14650, 16834, 16838, 16839

  def self.replace_attributes(record, *args)
    record['person_id'] = record['person_id']['@id']
    record['requirement_id'] = record['requirement_id']['@id']
    record['requirement_status_id'] = record['requirement_status_id']['@id']
    record['staff_id'] = record['staff_id']['@id']
    record['background_check_id'] = record['background_check_id']['@id']
    record
  end

  # Total Records
  # 7/29/2017 1
end
