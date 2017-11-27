class ALF::AddressType < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :address_type_id, :address_type

  # Name to be sent in request to API
  def self.alf_name
    "menu_address_type"
  end

  # Primary id key for record
  def self.id_attribute
    'address_type_id'
  end

  # Has many associations
  # :association_name => {class: 'ALF::Classname',
  #                 foreign_key: 'attribute with id in association'}
  def self.alf_has_many
    {
      :addresses => {class: "ALF::Address", foreign_key: 'address_type'}
    }
  end

end
