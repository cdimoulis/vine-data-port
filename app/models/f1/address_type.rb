# == Schema Information
#
# Table name: f1_address_types
#
#  id   :integer          not null, primary key
#  name :string
#  uri  :string
#

class F1::AddressType < F1::Base

  has_many :addresses, class_name: F1::Address.name

  ###
  # Helpful methods
  ###

  def self.print_names
    str = ''
    self.all.each do |r|
      str += "#{r.id}: #{r.name}\n"
    end

    puts str
  end


  ####
  # F1 stuff
  ####

  def self.base_route
    '/addresses/addresstypes'
  end

  def self.f1_attribute_map
    {

    }
  end

  # Total Records
  # 7/29/2017 9

  ####
  # CIVICRM model mapping
  ####

  # The mapping to civicrm
  def civicrm_models
    # If the name does not exist
    if !CIVICRM::LocationType.exists?({name: self.name})
      location_type = location_type_model()
      if !location_type.valid? || !location_type.save
        raise "Invalid Location Type Model\nF1::AddressType: #{self.inspect}\nCIVICRM::LocationType: #{location_type.errors.inspect}"
      end
    end
    # in case more needs to be done here
  end

  # Create the contact model
  def location_type_model
    CIVICRM::LocationType.new(
      name: self.name,
      display_name: self.name,
      vcard_name: self.name.upcase,
      is_reserved: false,
      is_active: true,
      is_default: false
    )
  end

  # Create all missing models
  def self.civicrm_create_all
    start = CIVICRM::LocationType.count
    F1::AddressType.all.each do |at|
      at.civicrm_models()
    end
    puts "\nCreated: #{CIVICRM::LocationType.count - start} CIVICRM::LocationType records From F1::AddressType records\n"
  end
end
