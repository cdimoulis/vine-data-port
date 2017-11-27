# == Schema Information
#
# Table name: f1_requirements
#
#  id                  :integer          not null, primary key
#  uri                 :string
#  old_id              :string
#  name                :string
#  is_active           :boolean
#  has_document        :boolean
#  is_confidential     :boolean
#  is_background_check :boolean
#  is_reference_check  :boolean
#  quantity            :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class F1::Requirement < F1::Base

  has_many :people_requirements, class_name: F1::PeopleRequirement.name

  def self.base_route
    '/requirements'
  end

  def self.f1_attribute_map
    {
      createdDate: 'created_at',
      lastUpdatedDate: 'updated_at'
    }
  end

  # Total Records
  # 7/29/2017 6
end
