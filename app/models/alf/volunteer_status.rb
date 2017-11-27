class ALF::VolunteerStatus < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :volunteer_status_id, :volunteer_status_name, :volunteer_status_symbol, :volunteer_status_type

  # Name to be sent in request to API
  def self.alf_name
    'menu_volunteer_status'
  end

  # Primary id key for record
  def self.id_attribute
    'volunteer_status_id'
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
