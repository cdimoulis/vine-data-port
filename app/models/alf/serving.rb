class ALF::Serving < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :id, :event_id, :room_id, :position_id, :category_id, :person_id, :attendance_id, :date, :hours, :comment, :schedule_id

  # Name to be sent in request to API
  def self.alf_name
    'reporting_serving'
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
