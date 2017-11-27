class ALF::DisplayAddress < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :address_id, :person_id, :household_id, :address_1, :address_2, :zip_code , :country, :address_type, :address_comment, :country_name, :city, :state, :county

  # Name to be sent in request to API
  def self.alf_name
    'display_address'
  end

  # Primary id key for record
  def self.id_attribute
    'address_id'
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
