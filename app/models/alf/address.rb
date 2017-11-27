class ALF::Address < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :address_id, :person, :household, :address_type, :address_1,
    :address_2, :zip_code, :country, :address_comment, :address_last_update,
    :address_created_date, :latitude, :longitude

  # Name to be sent in request to API
  def self.alf_name
    "info_address"
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
      :person => {class: "ALF::Person"},
      :household => {class: "ALF::Household"}
    }
  end

end
