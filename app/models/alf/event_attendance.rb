class ALF::EventAttendance < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :id, :person_id, :schedule_id, :parent_id, :checkin_time, :checkin_type, :created_by, :updated_by, :updated_on

  # Name to be sent in request to API
  def self.alf_name
    'reporting_event_attendance'
  end

  # Primary id key for record
  def self.id_attribute
    'id'
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
