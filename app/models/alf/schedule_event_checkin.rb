class ALF::ScheduleEventCheckin < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :id, :schedule_id, :checkin_open_date, :checkin_close_date, :registration_required, :event_series_access

  # Name to be sent in request to API
  def self.alf_name
    'schedule_event_checkin'
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
