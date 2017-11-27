# == Schema Information
#
# Table name: f1_timezones
#
#  id   :integer          not null, primary key
#  name :string
#  uri  :string
#

class F1::Timezone < F1::Base

  has_many :groups, class_name: F1::Group.name

  def self.group
    'groups'
  end

  def self.base_route
    '/timezones'
  end

  def self.f1_attribute_map
    {

    }
  end

  # Total Records
  # 7/29/2017 86
end
