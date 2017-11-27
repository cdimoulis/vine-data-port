# == Schema Information
#
# Table name: f1_background_check_statuses
#
#  id   :integer          not null, primary key
#  name :string
#  uri  :string
#

class F1::BackgroundCheckStatus < F1::Base

  # has_many :people_requirements, class_name: F1::PeopleRequirement.name

  def self.base_route
    '/requirements/backgroundcheckstatuses'
  end

  def self.f1_attribute_map
    {

    }
  end

  # Total Records
  # 7/29/2017 5
end
