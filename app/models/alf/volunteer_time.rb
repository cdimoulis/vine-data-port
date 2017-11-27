class ALF::VolunteerTime < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :volunteer_time_id, :volunteer_start_time, :volunteer_end_time

  # Name to be sent in request to API
  def self.alf_name
    'info_volunteer_time'
  end

  # Primary id key for record
  def self.id_attribute
    'volunteer_time_id'
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
