# == Schema Information
#
# Table name: f1_statuses
#
#  id   :integer          not null, primary key
#  name :string
#  uri  :string
#

class F1::Status < F1::Base

  has_many :people, class_name: F1::Person.name
  has_many :sub_statuses, class_name: F1::SubStatus.name

  def self.base_route
    '/people/statuses'
  end

  def self.f1_attribute_map
    {
      subStatus: nil
    }
  end

  # Total Records
  # 7/29/2017 20

  ####
  # Helper methods
  ####
  def self.print_names
    str = ''
    self.all.each do |r|
      str += "#{r.id}: #{r.name}\n"
    end

    puts str
  end


  ####
  # CIVICRM model mapping
  ####

  # The mapping to civicrm
  def civicrm_models
    option_value_model
  end

  def option_value_model
    CIVICRM::OptionValue.create_new_membership_status name
  end

  # Create all missing models
  def self.civicrm_create_all
    group = CIVICRM::OptionGroup.where(name: 'membership_status_20121112161808').take
    start = CIVICRM::OptionValue.where(option_group_id: group.id).count
    self.all.each do |r|
      r.civicrm_models
    end
    done = CIVICRM::OptionValue.where(option_group_id: group.id).count
    puts "Created: #{done - start} CIVICRM::OptionValue records From F1::Status records\n\n"
  end


end
