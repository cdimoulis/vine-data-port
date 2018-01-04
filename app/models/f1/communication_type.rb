# == Schema Information
#
# Table name: f1_communication_types
#
#  id           :integer          not null, primary key
#  uri          :string
#  general_type :string
#  name         :string
#

class F1::CommunicationType < F1::Base

  has_many :communications, class_name: F1::Communication.name

  ###
  # Helpful methods
  ###

  def self.get_records_by_type(type)
    self.where(general_type:type)
  end

  def self.print_names_by_type(type)
    str = ''
    get_records_by_type(type).each do |r|
      str += "#{r.id}: #{r.name}\n"
    end

    puts str
  end

  def self.print_names_and_types
    str = ''
    self.all.each do |r|
      str += "#{r.id}: #{r.general_type} - #{r.name}\n"
    end

    puts str
  end

  def self.print_types
    str = ''
    self.pluck('general_type').uniq.each do |t|
      str += "#{t}\n"
    end

    puts str
  end


  ####
  # F1 stuff
  ####

  def self.base_route
    '/communications/communicationtypes'
  end

  def self.f1_attribute_map
    {
      generalType: 'general_type'
    }
  end

  # Total Records
  # 7/29/2017 11

  ####
  # CIVICRM model mapping
  ####

  # The mapping to civicrm
  def self.civicrm_models
    telephone_models
  end

  # New CIVICRM option value models that need to be created
  def self.telephone_models
    # Need to create Emergency Option Value
    CIVICRM::OptionValue.create_new_phone_type "Emergency"
  end
end
