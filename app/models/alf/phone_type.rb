class ALF::PhoneType < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :phone_type_id, :phone_type

  # Name to be sent in request to API
  def self.alf_name
    'menu_phone_type'
  end

  # Primary id key for record
  def self.id_attribute
    'phone_type_id'
  end

  # Belongs to associations
  # :association_name => {class: 'ALF::Classname',
  #                 through: 'attribute in model',
  #                 assoc_attribute: 'matching attribute in association'}
  def self.alf_belongs_to
    {

    }
  end

  # Has many associations
  # :association_name => {class: 'ALF::Classname',
  #                 foreign_key: 'attribute with id in association'}
  def self.alf_has_many
    {

    }
  end

end
