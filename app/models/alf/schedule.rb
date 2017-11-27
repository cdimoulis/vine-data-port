class ALF::Schedule < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :schedule_id, :parent_id, :parent_event_id, :repeat_key, :schedule_name, :event, :type, :room, :position, :attribute, :description, :start_date, :end_date, :start_time, :end_time, :repeats, :repeat_every, :on_the, :repeat_on, :occurrence, :occurrence_end, :repeats_storage, :occurrence_storage, :allDay, :head_count, :head_count_adjusted

  # Name to be sent in request to API
  def self.alf_name
    'schedule'
  end

  # Primary id key for record
  def self.id_attribute
    'schedule_id'
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
